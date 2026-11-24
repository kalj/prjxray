title: 034b-cmt-mmcm-pips is disabled on kintex7 and virtex7 because of FREQ_BB bit conflicts
labels: bug,fuzzers,database,needs-vivado
upstream: 2061

As of openXC7/prjxray 6dabf706, `fuzzers/Makefile:155-159` skips 034b-cmt-mmcm-pips for kintex7 and virtex7, with a FIXME saying the fuzzer generates conflicting bits around the `FREQ_BB[N]` bits. The kintex7 `segbits_cmt_top_[lr]_lower_b.db` in openXC7/prjxray-db (0c3504f) does have the `CMT_LR_LOWER_B_MMCM_CLKFBIN/CLKIN1/CLKIN2 <- CLK_FREQ_BB0-3` and `MMCM_CLK_FREQ_BB_NS0-3` entries again (27 lines per file tagged `origin:034b-cmt-mmcm-pips`), but the CI database build cannot regenerate them. Any database rebuild for these families will drop them, which is what happened upstream after the iob18 merge.

### Next steps
- Run 034b on a kintex7 part, collect the conflicting segmatch output and find which FREQ_BB tags share bits (this may be the same direction problem as f4pga/prjxray#2460). Needs a Vivado fuzzer run.
- Fix the tag generation, re-enable 034b for kintex7 and virtex7 in `fuzzers/Makefile`, and check the result against the current db entries.

Imported from f4pga/prjxray#2061, opened by hansfbaier in 2022.
