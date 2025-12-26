# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit meson vala

DESCRIPTION="A GNOME library for spellchecking"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libspelling"
SRC_URI="https://download.gnome.org/sources/libspelling/0.4/libspelling-0.4.9.tar.xz -> libspelling-0.4.9.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="gtk-doc sysprof vala"
BDEPEND="dev-libs/gobject-introspection
	virtual/pkgconfig
	gtk-doc? ( dev-util/gi-docgen )
	
"
RDEPEND="dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/gtksourceview:5
	app-text/enchant
	dev-libs/icu:=
	
"
DEPEND="${RDEPEND}
	sysprof? ( dev-util/sysprof )
	vala? (
	  $(vala_depend)
	)
	
"
src_prepare() {
	use vala && vala_src_prepare
	default
}
src_configure() {
	local emesonargs=(
	  -Denchant=enabled
	  -Dinstall-static=false
	  $(meson_use gtk-doc docs)
	  $(meson_use sysprof)
	  $(meson_use vala vapi)
	)
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
	  mv "${ED}"/usr/share/doc/${PN}-${SLOT} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}


# vim: filetype=ebuild
