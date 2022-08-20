#!/bin/bash

mkdir /tmp/rust
cd /tmp/rust

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > setup_rust.rs

bash setup_rust.rs -y
