title: make -j in fuzzers fails with GNU make 4.4+ (jobserver fifo not supported)
labels: bug,fuzzers,good first issue
upstream: 2407

`make -j$(nproc)` in `fuzzers/` fails with `AssertionError: -j8 --jobserver-auth=fifo:/tmp/GMfifo8785` from run_fuzzer.py, while a serial `make` works. As of openXC7/prjxray 6dabf706, `fuzzers/run_fuzzer.py:547-551` only accepts the old pipe form:

```python
if '--jobserver-fds' in make_flags or '--jobserver-auth' in make_flags:
    job_re = re.search(
        '--jobserver-(?:fds|auth)=([0-9]+),([0-9]+)', make_flags)
    assert job_re, make_flags
```

GNU make 4.4 and later use a named fifo by default on Linux and pass `--jobserver-auth=fifo:PATH`, which this regex does not match. Lines 555-560 and 569 then pass the two fds to the child with `pass_fds`.

### Suggested fix
- If `--jobserver-auth=fifo:` is present, skip the fd handling (`job_fds = []`): the child make finds the fifo through the inherited `MAKEFLAGS`. Keep the `N,M` path for older make.
- Workaround until then: `make --jobserver-style=pipe -j$(nproc)`.

Imported from f4pga/prjxray#2407, opened by gsomlo in 2024.
