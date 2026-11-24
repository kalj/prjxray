# Open f4pga/prjxray issues, re-filed for openXC7

f4pga/prjxray is no longer maintained, and GitHub cannot transfer issues
between owners. This directory holds the upstream issues that still apply to
openXC7/prjxray, rewritten against openXC7 master (6dabf706), and a script that
files them. It is meant to be run once and is not for merging.

The triage behind the selection, with a verdict and the evidence for every
open upstream issue and pull request:
https://claude.ai/artifact/3LELCqdLgpFADWWoupVMEq

## Filing them

Requires the [GitHub CLI](https://cli.github.com/), logged in (`gh auth login`)
as someone allowed to create issues and labels on openXC7/prjxray.

```sh
cd upstream-issues
./file_issues.sh          # dry run: checks every file, prints what it would file
./file_issues.sh --yes    # creates missing labels, then files every issue
```

To file only some, pass their files: `./file_issues.sh --yes issues/0014-*.md`.
`--repo OWNER/NAME` files them somewhere else, e.g. a fork to try it out first.

The script creates any of the labels below that the repository lacks and
leaves existing labels alone. Every issue also gets `upstream-import`. Each
filed issue is recorded in `filed.tsv` (file, upstream number, new URL), and a
second run skips those, and any issue whose title already exists.

| Label | Used for |
|---|---|
| `bug`, `enhancement`, `documentation` | The usual meaning |
| `fuzzers`, `database`, `tools`, `ci` | The area |
| `needs-vivado` | Can only be done or confirmed with a Vivado run |
| `good first issue` | Small and self-contained, no Vivado needed |

The issues credit each original reporter by name, without an @-mention, so
nobody is notified. Each one links its upstream issue, so GitHub shows a
reference on the f4pga issue. The script posts nothing on f4pga/prjxray.

## What was left out

Of the 131 open upstream issues, 33 are fixed in openXC7, 19 are obsolete, 19
are questions and 9 are unclear without a Vivado run; none of those are here.
Of the 51 still relevant, these are not re-filed:

| Upstream | Why |
|---|---|
| #302 Rework the database directory structure | Would break every database consumer; suggest won't-fix |
| #484 Rename pip to int fuzzers | Churn only; suggest won't-fix |
| #1376 Building with unvendored dependencies | Covered by openXC7/prjxray#61 |
| #2 Versions in the htmlgen output | Only matters if openXC7 publishes the HTML |
| #303 Library less dependent on .json files | Only if an early-stage tool needs it |
| #1284 Move third-party designs under third_party/ | Housekeeping |
| #1343 xc7 prefix for the tools | Would break scripts; only if wanted |
| #1458 Automated database-update PRs | Only if the full database pipeline runs regularly |
| #1832 Validate the database with open-toolchain bitstreams | A proposal without an owner |

Three groups are merged into one issue each: #2300 with #2574 (bits outside a
tile's words), #804, #805 and #806 (docs FIXMEs), and #939 with #940 (mux
features without an all-zero entry). That makes 38 issues.
