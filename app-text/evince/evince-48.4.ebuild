# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit flag-o-matic gnome3 meson systemd

DESCRIPTION="Simple document viewer for GNOME"
HOMEPAGE="https://apps.gnome.org/Evince/"
SRC_URI="https://download.gnome.org/sources/evince/48/evince-48.4.tar.xz -> evince-48.4.tar.xz"
LICENSE="GPL-2+ CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="*"
IUSE="X cups djvu dvi gstreamer gnome keyring gtk-doc +introspection
postscript spell systemd tiff xps wayland
"
REQUIRED_USE="gtk-doc? ( introspection )"
# Commons depends
CDEPEND="app-accessibility/at-spi2-core
	dev-libs/glib:2
	dev-libs/libhandy
	dev-libs/libxml2:=
	sys-libs/zlib
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3[X?,cups?,introspection?,wayland?]
	gnome-base/gsettings-desktop-schemas
	x11-libs/cairo
	app-text/poppler:=[cairo]
	app-arch/libarchive:=
	djvu? ( app-text/djvu:= )
	dvi? (
	  app-text/libspectre:=
	  dev-libs/kpathsea:=
	)
	gstreamer? (
	  media-libs/gstreamer:1.0
	  media-libs/gst-plugins-base:1.0
	  media-libs/gst-plugins-good:1.0
	)
	gnome? ( gnome-base/gnome-desktop:= )
	keyring? ( app-crypt/libsecret )
	introspection? ( dev-libs/gobject-introspection:= )
	postscript? ( app-text/libspectre:= )
	spell? ( app-text/gspell:= )
	tiff? ( media-libs/tiff:= )
	xps? ( app-text/libgxps:= )
	
"
BDEPEND="gtk-doc? (
	  dev-util/gi-docgen
	  app-text/docbook-xml:4.3
	)
	dev-libs/appstream-glib
	dev-util/gdbus-codegen
	dev-util/itstool
	sys-devel/gettext
	virtual/pkgconfig
	
"
RDEPEND="${CDEPEND}
	gnome-base/gvfs
	gnome-base/librsvg
	
"
DEPEND="${CDEPEND}
"
src_prepare() {
	default
	xdg_environment_reset
}
src_configure() {
	local emesonargs=(
	  -Ddevelopment=false
	  -Dplatform=gnome
	  -Dviewer=true
	  -Dpreviewer=true
	  -Dthumbnailer=true
	  -Dnautilus=false
	  -Dcomics=enabled
	  -Dpdf=enabled
	  -Duser_doc=true
	  -Ddbus=true
	  -Dinternal_synctex=true
	  $(meson_feature djvu)
	  $(meson_feature dvi)
	  $(meson_feature postscript ps)
	  $(meson_feature tiff)
	  $(meson_feature xps)
	  $(meson_use gtk-doc gtk_doc)
	  $(meson_use introspection)
	  $(meson_feature keyring)
	  $(meson_feature cups gtk_unix_print)
	  $(meson_feature gnome thumbnail_cache)
	  $(meson_feature gstreamer multimedia)
	  $(meson_feature spell gspell)
	)
	 if use systemd ; then
	  emesonargs+=(
	    -Dsystemduserunitdir="$(systemd_get_userunitdir)"
	  )
	else
	  emesonargs+=(
	    -Dsystemduserunitdir="no"
	  )
	fi
	meson_src_configure
}
src_install() {
	meson_src_install
	if use gtk-doc; then
	  mkdir -p "${ED}"/usr/share/gtk-doc/html/ || die
	  mv "${ED}"/usr/share/doc/{libevdocument,libevview} "${ED}"/usr/share/gtk-doc/html/ || die
	fi
}
pkg_postinst() {
	gnome3_pkg_postinst
}
pkg_postrm() {
	gnome3_pkg_postrm
}


# vim: filetype=ebuild
