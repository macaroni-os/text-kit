# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cargo

DESCRIPTION="Small command-line JSON Log viewer"
HOMEPAGE="https://github.com/brocode/fblog"
SRC_URI="https://github.com/brocode/fblog/tarball/269966f4c2fcf61544c9ef92342f56b04e152fbe -> fblog-4.10.0-269966f.tar.gz
https://distfiles.macaronios.org/2b/88/25/2b88256505618d8970f49c39034d09be5a9b4ff8bebc66a2b8e2f08a004387d81cadcbc8a074e8126512f52c4a21daafb08ccdf210500ee494497a59f980bb35 -> fblog-4.10.0-funtoo-crates-bundle-007e27cdcde2cbeca6f96cc6062df96b576d9fd0fe76d00ea37594a271cf007089d7b970ae37a5c2475a647d0ab076cbeb822a493e8a12be99932422e2a30fef.tar.gz"

LICENSE="Apache-2.0 Boost-1.0 BSD BSD-2 CC0-1.0 ISC LGPL-3+ MIT Apache-2.0 Unlicense WTFPL-2 ZLIB"
SLOT="0"
KEYWORDS="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="virtual/rust"

DOCS=(
	README.md
	sample.json.log
	sample_context.log
	sample_nested.json.log
	sample_numbered.json.log
)

QA_FLAGS_IGNORED="/usr/bin/fblog"

src_unpack() {
	cargo_src_unpack
	rm -rf ${S}
	mv ${WORKDIR}/brocode-fblog-* ${S} || die
}