title: fasm2frames silently writes bits outside a tile's own words (*_SING tiles)
labels: bug,tools
upstream: 2300,2574

fasm2frames does not check that a feature's bits stay inside the tile's own `words` window after the tilegrid alias shift, and it exits 0 either way. As of openXC7/prjxray 6dabf706 there are two cases:

- Word address below 0. For a bottom `*_SING` tile (offset 0, alias `start_offset` 2), bits of the absent site shift to word -1 or -2. `frame_set()`/`frame_clear()` in `prjxray/fasm_assembler.py:166-207` only reject `word_addr >= 101`, so `frames[addr][-1]` in `get_frames()` (`prjxray/fasm_assembler.py:151`) writes into word 100, which belongs to another tile. Upstream example on xc7a100t: `LIOB33_SING_X0Y0.IOB_Y1.PULLTYPE.PULLUP` sets word 100 of frames 0x00420026/0x00420027, owned by `LIOB33_SING_X0Y49`.
- Word address above 100. For a top `*_SING` tile (offset 99, 2 words), Y0-site features land past the frame. In openXC7/prjxray-db (0c3504f), artix7 xc7a50t `LIOI3_SING_X0Y149` has offset 99, and `LIOI3.IOI_ILOGIC0_CLK.IOI_LEAF_GCLK0` uses bit `28_79`, so word 99 + 2 = 101. The bit is dropped with a message on stderr only (`prjxray/fasm_assembler.py:171-173`, `:193-195`).

The decode side already filters these bits: `TileSegbitsAlias.match_filter()` (`prjxray/tile_segbits_alias.py:101-107`) rejects words outside `0..words-1`. The encode path `feature_to_bits()` (`prjxray/tile_segbits_alias.py:119-126`) has no such check. openXC7/prjxray PRs #20 and #21 fixed the Y1 site of top SING IOB/IOI tiles (`start_offset` 0), but not these cases. nextpnr-xilinx output is not affected today, since it names the SING site correctly; hand-written or generated FASM is.

### Suggested fix
- After the alias shift, check each bit's word against the tile's `offset .. offset + words - 1` and report the feature and tile.
- Start as a warning (and a `--strict` option that raises `FasmLookupError`), because some real designs still hit the word > 100 case; make it an error once those are fixed.
- Add a test with one bottom and one top `*_SING` tile.

Imported from f4pga/prjxray#2300, opened by hansfbaier in 2024.
Imported from f4pga/prjxray#2574, opened by gHashTag in 2026.
