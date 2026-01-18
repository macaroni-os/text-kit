# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
ECARGO_BUNDLE_POSTFIX="mark-rust-bundle"
inherit cargo gnome3 meson

DESCRIPTION="A document viewer for the GNOME desktop"
HOMEPAGE="https://apps.gnome.org/Papers/"
SRC_URI="
https://download.gnome.org/sources/papers/49/papers-49.3.tar.xz -> papers-49.3.tar.xz
mirror://macaroni/papers-49.3-mark-rust-bundle.tar.xz -> papers-49.3-mark-rust-bundle.tar.xz"
LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="*"
IUSE="+comics djvu doc gnome-keyring introspection nautilus
+spell sysprof tiff
"
# Commons depends
CDEPEND="x11-libs/cairo
	x11-libs/gdk-pixbuf[introspection?]
	media-libs/graphene
	media-libs/libraw
	x11-libs/pango[introspection?]
	dev-libs/glib:2
	x11-libs/gtk:4
	x11-libs/libadwaita
	media-libs/exempi
	x11-libs/cairo
	sys-libs/zlib
	sysprof? ( dev-util/sysprof )
	nautilus? ( gnome-base/nautilus )
	introspection? ( dev-libs/gobject-introspection )
	spell? ( app-text/libspelling )
	comics? ( app-arch/libarchive )
	djvu? ( app-text/djvu )
	>=app-text/poppler-25.01.0
	x11-libs/cairo
	tiff? ( media-libs/tiff )
	
"
BDEPEND="
	virtual/pkgconfig
	dev-libs/appstream-glib
	doc? ( dev-util/gi-docgen )
	sys-devel/gettext
	
"
RDEPEND="${CDEPEND}
	gnome-keyring? ( app-crypt/libsecret )
	
"
DEPEND="${CDEPEND}
"
src_configure() {
	local emesonargs=(
	  -Dpdf=enabled
	  -Dtests=false
	  $(meson_feature sysprof)
	  $(meson_use nautilus)
	  $(meson_feature comics)
	  $(meson_feature djvu)
	  $(meson_feature tiff)
	  $(meson_use doc documentation)
	  $(meson_use doc user_doc)
	  $(meson_feature introspection)
	  $(meson_feature sysprof)
	  $(meson_feature gnome-keyring keyring)
	  $(meson_feature spell spell_check)
	)
	meson_src_configure
	ln -s "${CARGO_HOME}" "${BUILD_DIR}/cargo-home" || die
}
src_install() {
	meson_src_install
	if use doc; then
	  mv "${ED}"/usr/share/doc/{libpps*,${PF}/.} || die
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
