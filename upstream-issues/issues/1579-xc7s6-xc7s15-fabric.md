title: Add a fabric for xc7s6 / xc7s15 (Spartan Edge Accelerator Board)
labels: enhancement,database,fuzzers,needs-vivado
upstream: 1579

As of openXC7/prjxray 6dabf706, xc7s6 and xc7s15 have no fabric. `settings/spartan7/devices.yaml:13-18` leaves them unmapped on purpose: they are a separate, smaller die (1324 frames, 35 columns), and pointing them at another fabric would address the wrong frames. `settings/spartan7.sh` only has ROI settings for xc7s25 (line 18) and xc7s75/xc7s100 (line 33); xc7s6/xc7s15 fall through to the xc7s50 defaults (line 46). openXC7/prjxray-db master has package directories for xc7s6 and xc7s15 parts but fabric directories only for xc7s25, xc7s50 and xc7s100. Upstream data (UG470 bitstream lengths, DS189 quiescent currents) agrees that xc7s6 and xc7s15 share one die.

### Suggested fix
- Add an `xc7s15` case to `settings/spartan7.sh` with a tilegrid ROI, `XRAY_IOI3_TILES` and pins for that die, and map both xc7s6 and xc7s15 to it in `devices.yaml`.
- Run the tilegrid and part fuzzers for an xc7s15 package (for example csga225, as on the Spartan Edge Accelerator Board) and check which segbits the existing spartan7 database already covers. Needs a Vivado fuzzer run.

Imported from f4pga/prjxray#1579, opened by cederom in 2021.
