# stellar-scaffold-macro

This crate contains a utility macro for importing Soroban smart contracts. The main functionality is provided through the `import_contract!` macro which generates the necessary client code for interacting with Soroban contracts.

`import_contract_client!` is a [procedural macro](https://doc.rust-lang.org/reference/procedural-macros.html) that automatically generates a contract client for a given contract. It expects the contract name to match either a published contract or a contract in your current workspace. The macro will locate the contract's WASM file and generate the appropriate Rust bindings for interacting with it.

For example:
```rust
import_contract_client!(my_contract);
```

This will generate a module containing the client code needed to interact with `my_contract`.

See lib.rs for the implementation details of the import_contract_client macro.