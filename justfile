set dotenv-load

export PATH := './target/bin:' + env_var('PATH')
export CONFIG_DIR := 'target/'
# hash := `soroban contract install --wasm ./target/wasm32-unknown-unknown/contracts/example_status_message.wasm`



[private]
path:
    just --list

stellar-scaffold +args:
    @cargo run --bin stellar-scaffold -- {{args}}

s +args:
    @stellar {{args}}

stellar +args:
    @stellar {{args}}

build_contract p:
    stellar contract build --profile contracts --package {{p}}

# build contracts
build:
    just stellar-scaffold build

# Setup the project to use a pinned version of the CLI
setup:
    -cargo binstall -y stellar-cli --version 22.8.1 --install-path ./target/bin

# Build stellar-scaffold-cli test contracts to speed up testing
build-cli-test-contracts:
    just stellar-scaffold build --manifest-path crates/stellar-scaffold-test/fixtures/soroban-init-boilerplate/Cargo.toml

test: build
    cargo nextest run --workspace

test-integration: build-cli-test-contracts
    cargo nextest run -E 'package(stellar-scaffold-cli)' --features integration-tests

create: build
    rm -rf .soroban
    -stellar keys generate default --fund
    #just stellar contract deploy --wasm ./target/stellar/example_status_message.wasm --alias core --source-account default
