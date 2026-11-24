title: Document how to run the looping pip fuzzers (make vs make run)
labels: documentation,fuzzers,good first issue
upstream: 530

As of openXC7/prjxray 6dabf706, nothing under `docs/` explains how the looping fuzzers work. 27 fuzzer Makefiles include `fuzzers/pip_loop.mk` or `fuzzers/int_loop.mk` (for example 050-pip-seed, 056-pip-rem, 041-clk-hrow-pips, 037-iob-pips, 101-dsp-pips). For these, plain `make` runs a single iteration (`all: database`), while `make run` runs `fuzzers/int_loop.sh`, which repeats iterations until `fuzzers/int_loop_check.py` is satisfied and then runs `pushdb`. `fuzzers/run_fuzzer.py:565` uses `make run`. A user who runs `make` by hand gets a partial, unpushed result without warning.

### Suggested fix

- Add a section to `docs/db_dev_process/new_fuzzer.rst` (or a new page) covering `make` vs `make run`, `ITER`, `N`, `TODO_N`, `QUICK=Y`, `CHECK_ARGS`, and where the per-iteration TODO lists end up (`build/todo/`).
- No Vivado needed.

Imported from f4pga/prjxray#530, opened by litghost in 2019.
