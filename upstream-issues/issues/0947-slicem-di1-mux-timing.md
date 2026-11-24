title: No timing data for the SLICEM [ABC]DI1 muxes
labels: enhancement,fuzzers,database,needs-vivado
upstream: 947

As of openXC7/prjxray 6dabf706, the SLICEM has a mux in front of each of the A/B/C DI1 inputs (`ADI1MUX`, `BDI1MUX`, `CDI1MUX`). Its inputs are the [ABC]I pin or the next LUT's DI1/MC31 (site pips such as `ADI1MUX:AI`, `ADI1MUX:BDI1`, `ADI1MUX:BMC31` in artix7 `site_type_SLICEM.json`). The artix7 `timings/slicem.sdf` in openXC7/prjxray-db has `ROUTING_BEL` entries for other slice muxes (`ACY0`, `AMUX`, `F7AMUX`, `WEMUX`, and so on) but none for `ADI1MUX`, `BDI1MUX` or `CDI1MUX`. Upstream never found out whether Vivado exposes timing for these paths.

### Next steps

- In Vivado, place a SLICEM RAM design that uses each input of `ADI1MUX` and check `report_timing` / `write_sdf` for a delay through the mux.
- If Vivado reports one, extend `fuzzers/007-timing` to extract it. If not, note in the 007-timing docs that these muxes have zero delay in the SDF. Needs Vivado. Low priority.

Imported from f4pga/prjxray#947, opened by litghost in 2019.
