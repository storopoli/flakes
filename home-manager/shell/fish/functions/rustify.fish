function rustify
    if test -e ./Cargo.toml
        printf '\n' >>Cargo.toml
        printf '[lints.rust]\n' >>Cargo.toml
        printf 'unsafe_code = "forbid" # Forbid unsafe code\n' >>Cargo.toml
        printf '\n' >>Cargo.toml
        printf '[lints.clippy]\n' >>Cargo.toml
        printf 'enum_glob_use = "deny" # Deny `use Enum::*`\n' >>Cargo.toml
        printf 'pedantic = "deny"      # Deny a bunch of stuff\n' >>Cargo.toml
        printf 'nursery = "deny"       # Deny another bunch of stuff\n' >>Cargo.toml
        printf 'unwrap_used = "deny"   # Deny `.unwrap()`\n' >>Cargo.toml
        printf '\n' >>Cargo.toml
        printf '[profile.release]\n' >>Cargo.toml
        printf 'opt-level = "z"   # Optimized for size, use 3 for speed\n' >>Cargo.toml
        printf 'lto = true        # Enable Link Time Optimization\n' >>Cargo.toml
        printf 'codegen-units = 1 # Reduced to increase optimizations\n' >>Cargo.toml
        printf 'panic = "abort"   # Abort on panic\n' >>Cargo.toml
        printf 'strip = "symbols" # Strip symbols from binary\n' >>Cargo.toml
        $EDITOR Cargo.toml
    else
        printf 'Cannot detect Cargo.toml. Are you in a Rust project dir?'
    end
end
