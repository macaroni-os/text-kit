# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Console-based info reader"
HOMEPAGE="https://github.com/baszoetekouw/pinfo/"
SRC_URI="https://github.com/baszoetekouw/pinfo/tarball/0aeff7faf438ac910b032e2b19032e8ff9261862 -> pinfo-0.6.13-0aeff7f.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"

RDEPEND="sys-libs/ncurses:="
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
    "${FILESDIR}"/${PN}-0.6.13-gcc12-stricter-fixes.patch
)

post_src_unpack() {
	if [ ! -d "${S}" ]; then
		mv baszoetekouw-pinfo* "${S}" || die
	fi
}

src_prepare() {
	default
}

src_configure() {
	eautoreconf

	local myeconfargs=(
		--prefix=/usr
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	make DESTDIR="${D}" install
}