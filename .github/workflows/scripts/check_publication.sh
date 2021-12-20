#!/bin/bash
set -eu

while read -r crate_name; do
    if cargo search serde --limit 1 | grep "^$crate_name = "; then
        echo "'$crate_name' already published"
    else
        sed -i "s/^name \?=.*$/name = \"$crate_name\"/g" Cargo.toml
        cargo publish --dry-run
    fi
done < crate_names

sed -i "s/^name \?=.*$/name = \"\"/g" Cargo.toml
