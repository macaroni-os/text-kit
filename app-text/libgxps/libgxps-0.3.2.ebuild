# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson xdg-utils

DESCRIPTION="Library for handling and rendering XPS documents"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libgxps"
SRC_URI="https://download.gnome.org/sources/libgxps/0.3/libgxps-0.3.2.tar.xz -> libgxps-0.3.2.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection jpeg lcms tiff"
BDEPEND="dev-libs/libxslt
	dev-util/gtk-doc-am
	virtual/pkgconfig
	
"
RDEPEND="app-arch/libarchive
	dev-libs/glib:2
	media-libs/freetype:2
	media-libs/libpng
	x11-libs/cairo
	introspection? ( dev-libs/gobject-introspection:= )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	tiff? ( media-libs/tiff:0[zlib] )
	
"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	
"
src_configure() {
	local emesonargs=(
	  -Denable-test=false
	  -Denable-gtk-doc=false
	  -Denable-man=true
	  -Ddisable-introspection=$(usex introspection false true)
	  -Dwith-liblcms2=$(usex lcms true false)
	  -Dwith-libjpeg=$(usex jpeg true false)
	  -Dwith-libtiff=$(usex tiff true false)
	)
	xdg_environment_reset
	meson_src_configure
}


# vim: filetype=ebuild
