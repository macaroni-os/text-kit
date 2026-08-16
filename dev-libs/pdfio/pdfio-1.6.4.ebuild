# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7

DESCRIPTION="PDF read/write library"
HOMEPAGE="https://github.com/michaelrsweet/pdfio"
SRC_URI="https://api.github.com/repos/michaelrsweet/pdfio/tarball/refs/tags/v1.6.4 -> pdfio-1.6.4-48b185c.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE="png static-libs"
RDEPEND="sys-libs/zlib
	png? ( media-libs/libpng )
	
"
DEPEND="${RDEPEND}
	
"

post_src_unpack() {
	mv michaelrsweet-pdfio-* ${S}
}


src_configure() {
	local myeconfargs=(
	  --enable-shared
	  $(use_enable static-libs static)
	  $(use_enable png libpng)
	)
	 econf "${myeconfargs[@]}"
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install
}



# vim: filetype=ebuild
