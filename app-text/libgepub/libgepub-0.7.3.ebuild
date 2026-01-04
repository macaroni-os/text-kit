# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson

DESCRIPTION="GObject based library for handling and rendering epub documents"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libgepub"
SRC_URI="https://download.gnome.org/sources/libgepub/0.7/libgepub-0.7.3.tar.xz -> libgepub-0.7.3.tar.xz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="+introspection"
BDEPEND="virtual/pkgconfig
	
"
RDEPEND="app-arch/libarchive
	dev-libs/glib:2
	dev-libs/libxml2
	net-libs/libsoup:2.4
	net-libs/webkit-gtk:4
	x11-libs/gtk+:3
	introspection? ( dev-libs/gobject-introspection:= )
	
"
DEPEND="${RDEPEND}
"
src_configure() {
	meson_src_configure \
	  $(meson_use introspection introspection)
}


# vim: filetype=ebuild
