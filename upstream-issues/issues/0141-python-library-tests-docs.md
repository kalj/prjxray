title: Add unit tests and API docs for the prjxray Python package
labels: enhancement,tools
upstream: 141

As of openXC7/prjxray 6dabf706, the Python package in `prjxray/` (29 modules, including `db.py`, `tile.py`, `tile_segbits.py`, `grid.py`, `fasm2frames.py`) has almost no dedicated tests. Python coverage comes from doctests (`make test` runs `py.test --doctest-modules`, `Makefile:59`) and a few scripts. The library is also not covered by the Sphinx docs in `docs/`.

The upstream issue had no body. Filing it here as concrete, smaller items.

### Suggested fix

- Add pytest tests for `prjxray/db.py`, `prjxray/tile.py` and `prjxray/tile_segbits.py` using a tiny checked-in fixture database.
- Add an autodoc page for the main library classes (`Database`, `Grid`, `Tile`, `TileSegbits`) under `docs/`.
- Each item can be a separate PR. No Vivado needed.

Imported from f4pga/prjxray#141, opened by litghost in 2018.
