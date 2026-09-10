# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
LUA_COMPAT=( lua5-3 )
inherit lua-single qmake-utils toolchain-funcs xdg

DESCRIPTION="Converts source code to formatted text (HTML, LaTeX, etc.) with syntax highlight"
HOMEPAGE="https://gitlab.com/saalen/highlight"
SRC_URI="https://gitlab.com/saalen/highlight/-/archive/v4.21/highlight-v4.21.tar.bz2 -> highlight-4.21-688a907.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="examples gui"
REQUIRED_USE="${LUA_REQUIRED_USE}"
BDEPEND="virtual/pkgconfig
	gui? ( dev-qt/qttools:6[linguist] )
	
"
RDEPEND="${LUA_DEPS}
	gui? ( dev-qt/qtbase:6[gui] )
	
"
DEPEND="${RDEPEND}
	dev-libs/boost
	
"
S="${WORKDIR}/highlight-v4.21"
myhlopts=(
	CXX="$(tc-getCXX)"
	AR="$(tc-getAR)"
	LDFLAGS="${LDFLAGS}"
	CFLAGS="${CXXFLAGS} -DNDEBUG -std=c++17 -D_FILE_OFFSET_BITS=64"
	DESTDIR="${D}"
	PREFIX="${EPREFIX}/usr"
	HL_CONFIG_DIR="${EPREFIX}/etc/highlight/"
	HL_DATA_DIR="${EPREFIX}/usr/share/highlight/"
	hl_conf_dir="${EPREFIX}/etc/highlight/"
	hl_data_dir="${EPREFIX}/usr/share/highlight/"
	hl_doc_dir="${EPREFIX}/usr/share/doc/${PF}/"
	examples_dir="${EPREFIX}/usr/share/doc/${PF}/extras/"
)
hl_assert_pattern() {
	local re=$1 f
	shift
	for f ; do
		grep -Eq "${re}" "${f}" \
			|| die "pattern '${re}' no longer matches ${f}: upstream renamed it, re-check the sed that follows"
	done
}

src_prepare() {
	default

	# Disable man page compression
	hl_assert_pattern 'GZIP' makefile
	sed -e "/GZIP/d" -i makefile || die

	hl_assert_pattern "LSB_DOC_DIR.*doc/${PN}" src/core/datadir.cpp
	sed -e "/LSB_DOC_DIR/s:doc/${PN}:doc/${PF}:" \
		-i src/core/datadir.cpp || die

	hl_assert_pattern '^LUA_.*pkg-config.*\<lua\>' \
		extras/tcl/makefile extras/swig/makefile
	sed -r -e "/^LUA_.*pkg-config/s,\<lua\>,${ELUA},g" \
		-i extras/tcl/makefile extras/swig/makefile \
		|| die "failed to set Lua implementation for extras"

	hl_assert_pattern 'LIBS \+= -llua$' src/gui-qt/highlight.pro
	hl_assert_pattern 'PKGCONFIG \+= lua$' src/gui-qt/highlight.pro
	sed -e "/LIBS += -llua/d" \
		-e "s/PKGCONFIG += lua$/PKGCONFIG += ${ELUA}/" \
		-i src/gui-qt/highlight.pro \
		|| die "failed to set Lua implementation for the GUI"
}

src_configure() {
	if use gui ; then
		pushd src/gui-qt > /dev/null || die
		eqmake6 \
			'DEFINES+=HL_DATA_DIR=\\\"'"${EPREFIX}"'/usr/share/highlight/\\\" HL_CONFIG_DIR=\\\"'"${EPREFIX}"'/etc/highlight/\\\" HL_DOC_DIR=\\\"'"${EPREFIX}"'/usr/share/doc/'"${PF}"'/\\\"'
		popd > /dev/null || die
	fi
}

src_compile() {
	emake -f makefile LUA_PKG_NAME="${ELUA}" "${myhlopts[@]}"

	if use gui ; then
		emake -C src/gui-qt
	fi
}

src_install() {
	emake -f makefile "${myhlopts[@]}" install

	if use gui ; then
		emake -f makefile "${myhlopts[@]}" install-gui
	fi

	if use examples ; then
		docompress -x /usr/share/doc/${PF}/extras
	else
		rm -r "${ED}"/usr/share/doc/${PF}/extras || die
	fi
}


# vim: filetype=ebuild
