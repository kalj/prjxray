title: Looping fuzzers should fail early when the TODO list stops shrinking
labels: enhancement,fuzzers
upstream: 777

As of openXC7/prjxray 6dabf706, a looping fuzzer (`fuzzers/int_loop.sh` with `fuzzers/int_loop_check.py`) only fails on timeout, after `--timeout-iters` iterations (50 by default, `fuzzers/pip_loop.mk:22`). `--min-progress` is a success condition: when progress drops below it, `fuzzers/int_loop_check.py:123-125` exits 0 and the loop goes on to `pushdb` as if it had finished. A fuzzer stuck with a few unsolved pips therefore either runs dozens of useless iterations before failing, or stops and reports success. On timeout, `int_loop.sh` prints only "ERROR: timeout" and not the remaining TODO entries.

### Suggested fix

- Add `--min-progress-failure N` / `--min-progress-timeout K` to `int_loop_check.py`: fail if the TODO count has not dropped by N over the last K iterations. This was proposed upstream and never implemented.
- On timeout or stall failure, print the last `build/todo/<iter>_all.txt` so CI logs show what is left.
- The script change needs no Vivado; checking it on a real fuzzer does.

Imported from f4pga/prjxray#777, opened by mithro in 2019.
