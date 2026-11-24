title: Keep a single copy of picorv32.v
labels: enhancement,good first issue
upstream: 483

As of openXC7/prjxray 6dabf706, the same `picorv32.v` (git blob af634b47) is checked in six times: `experiments/example/`, `fuzzers/050-pip-seed/`, `fuzzers/051-pip-imuxlout-bypalts/`, `minitests/picorv32-v/`, `minitests/picorv32-y/` and `minitests/timing/`.

### Suggested fix

- Move one copy to a shared location (for example `third_party/picorv32/` or a common `utils/` directory) and point the six users' Tcl/Makefiles at it.
- Delete the other copies. No Vivado needed to make the change; a quick synthesis of one fuzzer confirms the path works.

Imported from f4pga/prjxray#483, opened by mcmasterg in 2019.
