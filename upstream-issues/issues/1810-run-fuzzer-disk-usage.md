title: run_fuzzer.py should log free disk space with load and memory
labels: enhancement,fuzzers,good first issue
upstream: 1810

As of openXC7/prjxray 6dabf706, `fuzzers/run_fuzzer.py:580-588` logs the load average and memory use every 10 seconds while a fuzzer runs, but not disk usage. Large fuzzers can fill a disk (see f4pga/prjxray#1214: 82 GB for 074 on xc7vx330t), and a full disk is currently hard to spot from the logs.

Upstream PR f4pga/prjxray#1910 is a starting point but should not be merged as is. It runs `df -h .` through a shell and parses the human-readable columns without `-P`, so long device names that wrap the line break the parsing. Its doctest expects the author's own disk figures (`{'free': '760G', 'used': '109G'}`) and fails on any other machine.

### Suggested fix
- Add `get_disk()` using `shutil.disk_usage(fuzzer_dir)` (no subprocess) and add "Disk: N Gi used, M Gi free" to the "Still running" message.
- Give it a doctest that does not depend on the machine (for example only check the keys and types).

Imported from f4pga/prjxray#1810, opened by mithro in 2021.
