{ ... }:

{
  home.file.".julia/config/startup.jl".text = ''
    if isinteractive()
      try
        using Revise
      catch e
        @warn "Error initializing Revise"
      end
      try
        @eval using VimBindings
      catch e
        @warn "Error initializing VimBindings"
      end
    end
  '';
}
