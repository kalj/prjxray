title: Database lacks the reverse direction of CMT FREQ_BB pips used by nextpnr-xilinx
labels: bug,database,fuzzers,needs-vivado
upstream: 2460

fasm2frames fails on some nextpnr-xilinx FASM that routes a clock through the CMT frequency backbone into PLL CLKIN2 (reported on a Cmod A7, xc7a35t):

```
CMT_TOP_R_LOWER_B.MMCM_CLK_FREQ_BB_REBUF2_NS.MMCM_CLK_FREQ_BB_NS2
CMT_TOP_R_UPPER_T.PLL_CLK_FREQ_BB2_NS.PLL_CLK_FREQ_BB_BUFOUT_NS2
```

These pips are bidirectional in `tile_type_*.json`, but the database has one direction only. In openXC7/prjxray-db (0c3504f), artix7 `segbits_cmt_top_r_lower_b.db` has `MMCM_CLK_FREQ_BB_NS2.MMCM_CLK_FREQ_BB_REBUF2_NS` (4 bits) and `ppips_cmt_top_r_upper_t.db` has `PLL_CLK_FREQ_BB_BUFOUT_NS2.PLL_CLK_FREQ_BB2_NS always`, but neither reverse key. The same holds for lines 0-3. A route built with nextpnr-himbaechel-xilinx 0.11.1 avoids these pips and assembles, so this is low priority.

### Suggested fix
- Extend 034/034b to force routes through the reverse direction and solve its bits; the PLL side may be a no-bits pseudo-pip that only needs a ppips entry. Needs a Vivado fuzzer run. Related: 034b is disabled on kintex7/virtex7 because of FREQ_BB conflicts (f4pga/prjxray#2061).
- Until then, nextpnr could be kept from using the reverse direction (outside this repository).

Imported from f4pga/prjxray#2460, opened by chrisjohgorman in 2024.
