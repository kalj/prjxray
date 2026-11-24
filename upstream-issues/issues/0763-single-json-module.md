title: Use one JSON module across the Python code
labels: enhancement,tools,good first issue
upstream: 763

As of openXC7/prjxray 6dabf706, the Python code uses three JSON libraries. Most files use the standard `json`. `prjxray/db.py:14` uses `simplejson as json`. Several `fuzzers/074-dump_all/` scripts, `utils/clean_json5.py` and `utils/verify_tile_connections.py` use `pyjson5` to read the trailing-comma JSON that the Tcl scripts write. `fuzzers/074-dump_all/cleanup_site_pins.py:23` imports `json5`, which is not in `requirements.txt` or `setup.py`; nothing references that script, so it may be dead code (not verified).

### Suggested fix

- Switch `prjxray/db.py` to the standard `json` and drop `simplejson` from `setup.py` and `requirements.txt` if nothing else needs it.
- Either keep `pyjson5` only where Tcl output is parsed, or make the Tcl writers emit strict JSON and use `json` everywhere.
- Remove `cleanup_site_pins.py` if it is unused, or switch it to `pyjson5`. No Vivado needed.

Imported from f4pga/prjxray#763, opened by elms in 2019.
