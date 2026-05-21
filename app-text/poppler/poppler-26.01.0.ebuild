# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
CMAKE_BUILD_TYPE="RelWithDebInfo"
inherit cmake toolchain-funcs xdg-utils

DESCRIPTION="PDF rendering library based on the xpdf-3.0 code base"
HOMEPAGE="https://poppler.freedesktop.org/"
SRC_URI="https://poppler.freedesktop.org/poppler-26.01.0.tar.xz -> poppler-26.01.0.tar.xz"
LICENSE="BSD GPL-2 MIT"
SLOT="0"
KEYWORDS="*"
IUSE="boost cairo cjk curl +cxx debug doc +introspection
+jpeg +jpeg2k +lcms nss png qt5 qt6 tiff +utils
"
# Commons depends
CDEPEND="media-libs/fontconfig
	>=media-libs/freetype-2.14.1
	dev-libs/nss
	sys-libs/zlib
	cairo? (
	  dev-libs/glib:2
	  x11-libs/cairo
	  introspection? ( dev-libs/gobject-introspection:= )
	)
	curl? ( net-misc/curl )
	jpeg? ( virtual/jpeg )
	jpeg2k? ( media-libs/openjpeg:= )
	lcms? ( media-libs/lcms )
	nss? ( dev-libs/nss )
	png? ( media-libs/libpng:= )
	qt5? (
	  dev-qt/qtcore:5
	  dev-qt/qtgui:5
	  dev-qt/qtxml:5
	)
	qt6? (
	  dev-qt/qtbase:6
	)
	tiff? ( >=media-libs/tiff-4.7.1 )
	
"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	cjk? ( app-text/poppler-data )
	
"
DEPEND="${CDEPEND}
"
post_src_unpack() {
	if [ ! -d "${S}" ]; then
	  mv ${WORKDIR}/poppler-poppler-* ${S} || die
	fi
}
src_prepare() {
	cmake_src_prepare
	# Clang doesn't grok this flag, the configure nicely tests that, but
	# cmake just uses it, so remove it if we use clang
	if [[ ${CC} == clang ]] ; then
	  sed -e 's/-fno-check-new//' -i cmake/modules/PopplerMacros.cmake || die
	fi
	if ! grep -Fq 'cmake_policy(SET CMP0002 OLD)' CMakeLists.txt ; then
	  sed -e '/^cmake_minimum_required/acmake_policy(SET CMP0002 OLD)' \
	    -i CMakeLists.txt || die
	else
	  einfo "policy(SET CMP0002 OLD) - workaround can be removed"
	fi
}
src_configure() {
	xdg_environment_reset
	local mycmakeargs=(
	  -DBUILD_GTK_TESTS=OFF
	  -DBUILD_QT5_TESTS=OFF
	  -DBUILD_CPP_TESTS=OFF
	  -DRUN_GPERF_IF_PRESENT=OFF
	  -DENABLE_BOOST=$(usex boost)
	  -DENABLE_ZLIB=ON
	  -DENABLE_ZLIB_UNCOMPRESS=OFF
	  -DENABLE_UNSTABLE_API_ABI_HEADERS=ON
	  -DUSE_FLOAT=OFF
	  -DWITH_Cairo=$(usex cairo)
	  -DENABLE_LIBCURL=$(usex curl)
	  -DENABLE_CPP=$(usex cxx)
	  -DWITH_JPEG=$(usex jpeg)
	  -DENABLE_DCTDECODER=$(usex jpeg libjpeg none)
	  -DENABLE_LIBOPENJPEG=$(usex jpeg2k openjpeg2 none)
	  -DENABLE_CMS=$(usex lcms lcms2 none)
	  -DWITH_NSS3=$(usex nss)
	  -DWITH_PNG=$(usex png)
	  $(cmake_use_find_package qt5 Qt5Core)
	  -DWITH_TIFF=$(usex tiff)
	  -DENABLE_UTILS=$(usex utils)
	  -DENABLE_QT5=$(usex qt5)
	  -DENABLE_QT6=$(usex qt6)
	  -DENABLE_GPGME=OFF
	)
	use cairo && mycmakeargs+=( -DWITH_GObjectIntrospection=$(usex introspection) )
	cmake_src_configure
}
src_install() {
	cmake_src_install
}


# vim: filetype=ebuild
