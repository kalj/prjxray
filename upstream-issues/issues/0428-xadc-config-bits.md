title: Finish the 033-mon-xadc fuzzer and add XADC config bits to the db
labels: enhancement,fuzzers,database,needs-vivado
upstream: 428

As of openXC7/prjxray 6dabf706, `fuzzers/033-mon-xadc/` exists (top.py, generate.py, bits.dbf, README) but is not listed in `fuzzers/Makefile`, so it never runs. Its README says the XADC is outside the default ROI and that 005-tilegrid must be run first with a custom `XRAY_ROI` / `XRAY_ROI_GRID_Y2`. The current openXC7/prjxray-db has `tile_type_MONITOR_*.json` and `site_type_XADC.json` but no `segbits_monitor*.db` for any family, so XADC attributes cannot be set from FASM. The artix7 xc7a50t `tilegrid.json` already has a `CLB_IO_CLK` base address for `MONITOR_BOT_X46Y79`, so the README's ROI step may be stale (not verified).

Upstream noted the fuzzer was started as an entry-level task and was expected to be easy to finish.

### Next steps

- Check whether 033-mon-xadc runs against the current tilegrid without the README's ROI override, update the README, and add the fuzzer to `fuzzers/Makefile`.
- Run the fuzzer for artix7 and check the resulting segbits. Needs a Vivado fuzzer run.
- Extend `fuzzers/033-mon-xadc/top.py` to cover the remaining XADC INIT registers.

Imported from f4pga/prjxray#428, opened by JohnDMcMaster in 2019.
