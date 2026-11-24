#!/usr/bin/env bash
# Copyright (C) 2026  The Project X-Ray Authors.
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC
#
# File the issues in issues/*.md on openXC7/prjxray with the GitHub CLI.
#
# Without --yes this is a dry run: it checks every file and prints what it
# would file, and changes nothing. With --yes it creates any missing labels,
# files each issue and records it in filed.tsv, so running it again skips the
# issues already filed. An issue whose title already exists in the repository
# is skipped too.
#
# Usage: ./file_issues.sh [--yes] [--repo OWNER/NAME] [FILE...]

set -euo pipefail

repo="openXC7/prjxray"
apply=0
files=()
while [ $# -gt 0 ]; do
    case "$1" in
    --yes) apply=1 ;;
    --repo)
        repo="$2"
        shift
        ;;
    -h | --help)
        sed -n '10,18p' "$0" | sed 's/^# \{0,1\}//'
        exit 0
        ;;
    -*)
        echo "unknown option: $1" >&2
        exit 2
        ;;
    *) files+=("$1") ;;
    esac
    shift
done

here="$(cd "$(dirname "$0")" && pwd)"
if [ ${#files[@]} -eq 0 ]; then
    files=("$here"/issues/*.md)
fi
log="$here/filed.tsv"

# Every label an issue may use, with the colour and description to create it
# with if the repository does not have it yet. Existing labels are left as
# they are.
declare -A label_color=(
    [bug]=d73a4a [enhancement]=a2eeef [documentation]=0075ca
    ["good first issue"]=7057ff [fuzzers]=c5def5 [database]=bfdadc
    [tools]=d4c5f9 [ci]=ededed [needs-vivado]=fbca04 [upstream-import]=cccccc)
declare -A label_desc=(
    [bug]="Something isn't working" [enhancement]="New feature or request"
    [documentation]="Improvements or additions to documentation"
    ["good first issue"]="Good for newcomers"
    [fuzzers]="Fuzzers and database generation" [database]="Missing or wrong database contents"
    [tools]="C++ tools and Python utilities" [ci]="Continuous integration"
    [needs-vivado]="Needs a Vivado run to do or confirm"
    [upstream-import]="Re-filed from an open f4pga/prjxray issue")

field() { # field FILE NAME -> value of the "NAME: value" header line
    sed -n "1,3s/^$2: //p" "$1"
}

errors=0
for f in "${files[@]}"; do
    title="$(field "$f" title)"
    labels="$(field "$f" labels)"
    upstream="$(field "$f" upstream)"
    if [ -z "$title" ] || [ -z "$labels" ] || [ -z "$upstream" ] || [ -n "$(sed -n 4p "$f")" ]; then
        echo "$f: the first lines must be title:, labels:, upstream: and a blank line" >&2
        errors=$((errors + 1))
        continue
    fi
    IFS=, read -ra list <<<"$labels"
    for l in "${list[@]}"; do
        if [ -z "${label_color[$l]+x}" ]; then
            echo "$f: unknown label '$l'" >&2
            errors=$((errors + 1))
        fi
    done
done
if [ $errors -gt 0 ]; then
    echo "$errors problem(s) found; nothing filed" >&2
    exit 1
fi

if [ $apply -eq 1 ]; then
    existing_labels="$(gh label list --repo "$repo" --limit 500 --json name --jq '.[].name')"
    for l in "${!label_color[@]}"; do
        if ! grep -qxF "$l" <<<"$existing_labels"; then
            echo "creating label '$l'"
            gh label create "$l" --repo "$repo" --color "${label_color[$l]}" --description "${label_desc[$l]}"
        fi
    done
    existing_titles="$(gh issue list --repo "$repo" --state all --limit 1000 --json title --jq '.[].title')"
fi

filed=0
skipped=0
for f in "${files[@]}"; do
    name="$(basename "$f")"
    title="$(field "$f" title)"
    labels="$(field "$f" labels),upstream-import"
    if [ -f "$log" ] && grep -q "^$name	" "$log"; then
        echo "skip (already filed): $name"
        skipped=$((skipped + 1))
        continue
    fi
    if [ $apply -eq 0 ]; then
        printf 'would file: %s\n    title:  %s\n    labels: %s\n' "$name" "$title" "$labels"
        continue
    fi
    if grep -qxF "$title" <<<"$existing_titles"; then
        echo "skip (title exists in $repo): $name"
        skipped=$((skipped + 1))
        continue
    fi
    body="$(mktemp)"
    tail -n +5 "$f" >"$body"
    args=()
    IFS=, read -ra list <<<"$labels"
    for l in "${list[@]}"; do args+=(--label "$l"); done
    url="$(gh issue create --repo "$repo" --title "$title" --body-file "$body" "${args[@]}")"
    rm -f "$body"
    printf '%s\t%s\t%s\n' "$name" "$(field "$f" upstream)" "$url" >>"$log"
    echo "filed: $name -> $url"
    filed=$((filed + 1))
    sleep 2 # stay well inside GitHub's secondary rate limits
done

if [ $apply -eq 0 ]; then
    echo "dry run: ${#files[@]} file(s) checked; run with --yes to file them on $repo"
else
    echo "filed $filed, skipped $skipped; see $log"
fi
