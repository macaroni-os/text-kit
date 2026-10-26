# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit cmake

DESCRIPTION="Command-line tool for structural, content-preserving transformation of PDF files"
HOMEPAGE="https://qpdf.sourceforge.io/
https://github.com/qpdf/qpdf/
"
SRC_URI="
https://github.com/qpdf/qpdf/releases/download/v12.4.1/qpdf-12.4.1.tar.gz -> qpdf-12.4.1.tar.gz
https://github.com/qpdf/qpdf/releases/download/v12.4.1/qpdf-12.4.1-doc.zip -> qpdf-12.4.1-doc.zip"
LICENSE="|| ( Apache-2.0 Artistic-2 )"
SLOT="0"
KEYWORDS="*"
IUSE="doc examples gnutls zopfli"
BDEPEND="dev-lang/perl
	doc? ( app-arch/unzip )
	
"
RDEPEND="media-libs/libjpeg-turbo:=
	sys-libs/zlib
	gnutls? ( net-libs/gnutls:= )
	!gnutls? ( dev-libs/openssl:= )
	zopfli? ( app-arch/zopfli:= )
	
"
DEPEND="${RDEPEND}
	
"

post_src_unpack() {
	mv qpdf-qpdf-* ${S}
}


src_configure() {
	local crypto_provider=$(usex gnutls GNUTLS OPENSSL)
	local crypto_provider_lowercase=${crypto_provider,,}
	 # Keep an eye on https://qpdf.readthedocs.io/en/stable/packaging.html.
	local mycmakeargs=(
	  -DINSTALL_EXAMPLES=$(usex examples)
	  -DZOPFLI=$(usex zopfli)
	   # Avoid automagic crypto deps
	  -DUSE_IMPLICIT_CRYPTO=OFF
	  -DALLOW_CRYPTO_NATIVE=ON
	   -DDEFAULT_CRYPTO=${crypto_provider_lowercase}
	  -DREQUIRE_CRYPTO_${crypto_provider}=ON
	)
	 cmake_src_configure
}

src_install() {
	if use doc ; then
	  mv "${WORKDIR}"/${P}-doc "${BUILD_DIR}"/manual/doc-dist || die
	fi
	 cmake_src_install
}



# vim: filetype=ebuild
