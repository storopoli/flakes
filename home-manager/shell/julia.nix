{ ... }:

{
  home.file.".julia/config/startup.jl".text = ''
    try
        using Revise
    catch e
        @warn "Error initializing Revise"
    end
  '';
}
