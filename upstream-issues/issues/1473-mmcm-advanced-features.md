title: Document MMCM fine phase shift, CLKOUT4/6 cascade and spread-spectrum bits
labels: enhancement,fuzzers,database,needs-vivado
upstream: 1473

The MMCM register bank, local control inputs, compensation and startup wait are documented, but several advanced MMCME2_ADV features have no bits. As of openXC7/prjxray 6dabf706, fuzzer 031-cmt-mmcm only tags `SS_EN` (`fuzzers/031-cmt-mmcm/generate.py:66-67`), and the database (openXC7/prjxray-db 0c3504f, artix7 `segbits_cmt_top_[lr]_lower_b.db`) has `MMCME2_ADV.SS_EN` but nothing for:

- `CLKOUT4_CASCADE` and `CLKOUT6_CASCADE`
- `CLKOUTn_USE_FINE_PS` / `CLKFBOUT_USE_FINE_PS` (upstream's early tests pointed at the MX[0] bit of ClkReg2, per XAPP888; unconfirmed)
- the spread-spectrum mode and modulation parameters (`SS_MODE`, `SS_MOD_PERIOD`)

### Suggested fix
- Extend 031-cmt-mmcm (and 034b-cmt-mmcm-pips if routing is involved) to randomize these parameters and add their tags.
- Needs a Vivado fuzzer run, then a database update in openXC7/prjxray-db.

Imported from f4pga/prjxray#1473, opened by mkurc-ant in 2020.
