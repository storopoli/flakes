# https://uncomfyhalomacro.pl/blog/14/
import Pkg
project_path = let
    dirname(something(
        Base.load_path_expand((
            p = get(ENV, "JULIA_PROJECT", nothing);
            isnothing(p) ? nothing : isempty(p) ? nothing : p
        )),
        Base.current_project(pwd()),
        Pkg.Types.Context().env.project_file,
        Base.active_project(),
    ))
end

ls_install_path = joinpath(get(DEPOT_PATH, 1, joinpath(homedir(), ".julia")), "environments", "helix-lsp");
pushfirst!(LOAD_PATH, ls_install_path);
using LanguageServer;
popfirst!(LOAD_PATH);
depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
symbol_server_path = joinpath(homedir(), ".cache", "helix", "julia_lsp_symbol_server")
mkpath(symbol_server_path)
server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path, nothing, symbol_server_path, true)
server.runlinter = true
run(server)
