title: segprint.py should use the prjxray library for segbits and tilegrid
labels: enhancement,tools
upstream: 226

As of openXC7/prjxray 6dabf706, `utils/segprint.py` still has its own parsing code instead of using the `prjxray` library. `get_database()` (`utils/segprint.py:47`) reads the segbits and ppips files line by line and parses the tags itself, and `load_tiles()` (`utils/segprint.py:431`) loads `tilegrid.json` directly, with a "TODO: Migrate to new tilegrid format via library" comment. The library already provides `Database.get_tile_segbits()` and `Database.grid()` for this.

### Suggested fix

- Replace `get_database()` / `process_db()` with `db.get_tile_segbits(tile_type)` and the `TileSegbits` API.
- Replace `load_tiles()` with `db.grid()`, then remove the duplicated parsing code.
- Check that `segprint` output on an existing bitstream is unchanged before and after. No Vivado needed. Low priority.

Imported from f4pga/prjxray#226, opened by mcmasterg in 2018.
