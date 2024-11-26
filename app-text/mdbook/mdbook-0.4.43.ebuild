# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Create a book from markdown files"
HOMEPAGE="https://rust-lang.github.io/mdBook/"
SRC_URI="https://github.com/rust-lang/mdBook/tarball/74b2c79d46df45ab9c196646f98339dd7e0c00c3 -> mdBook-0.4.43-74b2c79.tar.gz
https://distfiles.macaronios.org/1f/56/31/1f56312e78d3a1a755e0a2f370a8320441747e6373b61e4f48af45dcb806fdc3ad85ba5c1b890b74fd25f12063a158e0a527bd5dc05bc5dadb3e947f69320471 -> mdbook-0.4.43-funtoo-crates-bundle-5d5d4e7c83fd31079e90d1bcccf62f6be4abf27f1a4db08ce64003a3f33ae116171dcd7a94189c9fc2e5c9d955c665edd691e43d2cf55b30fefdcaf7d4e5d8d9.tar.gz"
S="${WORKDIR}/rust-lang-mdBook-74b2c79"

# CC-BY-4.0/OFL-1.1: embeds fonts inside the executable
LICENSE="MPL-2.0 CC-BY-4.0 OFL-1.1"
LICENSE+="
	Apache-2.0 BSD ISC MIT Unicode-DFS-2016
	|| ( Artistic-2 CC0-1.0 )
" # crates
SLOT="0"
KEYWORDS="*"
IUSE="doc"

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	cargo_src_compile

	if use doc; then
		if tc-is-cross-compiler; then
			ewarn "html docs were skipped due to cross-compilation"
		else
			target/$(usex debug{,} release)/${PN} build -d html guide || die
		fi
	fi
}

src_install() {
	cargo_src_install

	dodoc CHANGELOG.md README.md
	use doc && ! tc-is-cross-compiler && dodoc -r guide/html
}