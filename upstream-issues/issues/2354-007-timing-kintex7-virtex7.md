title: 007-timing is skipped on kintex7 and virtex7, so the kintex7 database has no timings
labels: enhancement,fuzzers,database,needs-vivado
upstream: 2354

As of openXC7/prjxray 6dabf706, `fuzzers/Makefile:125-127` runs 007-timing only when `XRAY_DATABASE` is not kintex7 or virtex7. The skip came from commit 44737896 ("fuzzers: Disable timing fuzzer on Kintex.", 2019), which gives no reason. In openXC7/prjxray-db (0c3504f), `artix7/timings`, `spartan7/timings` and `zynq7/timings` exist, but kintex7 has no `timings` directory. virtex7 was not in the checked tree; openXC7/prjxray-db#32 ("virtex7/timings-from-vivado") suggests its timings came another way (not checked).

### Next steps
- Remove kintex7 from the filter and run 007-timing on a kintex7 part to see whether and why it fails (runtime, memory or a real error). Needs a Vivado fuzzer run.
- Fix what breaks, then push the timings to openXC7/prjxray-db and do the same for virtex7 if its timings are not already covered.

Imported from f4pga/prjxray#2354, opened by liibin in 2024.
