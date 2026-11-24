title: 005-tilegrid add_tdb.py hard-codes frame counts per tile type
labels: enhancement,fuzzers,good first issue
upstream: 444

As of openXC7/prjxray 6dabf706, `fuzzers/005-tilegrid/add_tdb.py:102` still carries "FIXME: generate frames from part file (or equivilent)". The `tdb_fns` table that follows (`add_tdb.py:106-141`) hard-codes the frame count and word count for every tile type, for example `("clb", 36, 2)`, `("bram_block", 128, 10)`, `("gtp_common", 32, 101)`. Every new tile type or family needs a manual edit here. The frame counts are already in `part.yaml` under `global_clock_regions` / `configuration_columns` / `frame_count`.

openXC7 already has a reader for this: `part_frame_counts()` in `utils/tilegrid_model.py:152` returns `(bottom, row, bus, column) -> frame_count` straight from `part.yaml`.

### Suggested fix

- In `add_tdb.py`, look up the frame count for each tile's base address via `utils/tilegrid_model.part_frame_counts()` instead of the hard-coded value, and keep the table only for word counts.
- Check that the generated `tilegrid.json` is unchanged for the existing parts. This can be done on existing 005 build outputs without a new Vivado run.

Imported from f4pga/prjxray#444, opened by mcmasterg in 2019.
