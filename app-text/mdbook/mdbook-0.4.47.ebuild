# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Create a book from markdown files"
HOMEPAGE="https://rust-lang.github.io/mdBook/"
SRC_URI="https://github.com/rust-lang/mdBook/tarball/07b25cdb643899aeca2307fbab7690fa7eeec36b -> mdBook-0.4.47-07b25cd.tar.gz
https://distfiles.macaronios.org/e6/3f/ca/e63fca144f36e32a05afb053bc9770ca9b1594979e40114493c6176f996a68bf6e1db961437631424d96e1c1547ee2f703a2a8a79817572c6b77a56cf133ce9f -> mdbook-0.4.47-funtoo-crates-bundle-1832443b4de3690f8f5c9857923492943c4037e0690a4e06aef27df9dfbbde4308e1195de9550f959800caa8c20e5223d370bfb0096becaa8497c70e9dcdd4ab.tar.gz"
S="${WORKDIR}/rust-lang-mdBook-07b25cd"

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