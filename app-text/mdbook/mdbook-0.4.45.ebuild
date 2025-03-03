# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Create a book from markdown files"
HOMEPAGE="https://rust-lang.github.io/mdBook/"
SRC_URI="https://github.com/rust-lang/mdBook/tarball/4941acdb8705728a5ea9d77987f31fdafefdcee1 -> mdBook-0.4.45-4941acd.tar.gz
https://distfiles.macaronios.org/9b/ae/41/9bae419fedddd1f0679c934570e337feaea4f1f60a6f865be60cdbd2b72ac758aed8707af7587158cf4402c12e51a370d48b2c6933bc6319c6ce6fb8a0596d84 -> mdbook-0.4.45-funtoo-crates-bundle-4a4b465c481e86d55c6ccc6c98b4a3725d0f11fe32175c4e55464b4159229c1073efa138ec30d68fe4fb341cc2f964d074ee92badf1cc7c37e98529ef6b725a6.tar.gz"
S="${WORKDIR}/rust-lang-mdBook-4941acd"

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