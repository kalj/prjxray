title: Fuzzers 072 and 074 are too slow and use too much disk on large parts
labels: enhancement,fuzzers,needs-vivado
upstream: 1214

As of openXC7/prjxray 6dabf706, fuzzers 072-ordered_wires and 074-dump_all still write one small file per tile and keep them all on disk until the run ends. `fuzzers/074-dump_all/jobtiles.tcl:45` opens one `tile_<name>.json5` per tile, and `fuzzers/074-dump_all/Makefile:39` deletes the `*.json5` files only after `pushdb` succeeds. Upstream reported 82 GB of disk (about 174k json5 files), 66.5 GB of peak virtual memory and a 20-day 074 run on xc7vx330t, with CPU at 1-3% (I/O bound). Concatenating and compressing the files with lz4 brought them to about 4 GB. openXC7 now builds virtex7 and large kintex7 parts, so this matters more than it did upstream.

On zynq7010 the per-tile pip loop in `jobtiles.tcl` (around line 121) was the main cost: dropping it cut the tiles job from about 44 to 8 minutes.

### Suggested fix
- Write one packed, compressed file per Vivado job (or per tile type) instead of one json5 per tile, and update the readers in `fuzzers/074-dump_all/` to match.
- Profile `jobtiles.tcl` on a large part and cut the per-pip queries (for example, write speed model indices only and resolve them once per tile type).
- Needs Vivado runs on a large part to measure before and after. See also the disk-usage logging issue (f4pga/prjxray#1810).

Imported from f4pga/prjxray#1214, opened by acomodi in 2020.
