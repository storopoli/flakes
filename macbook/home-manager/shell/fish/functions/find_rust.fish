function find_rust
    rg -A 10 "fn $argv\("
end
