using Documenter
using Neet

makedocs(
    sitename = "Neet",
    format = :html,
    modules = [Neet],
    pages = [
        "index.md",
        "core.md"
    ]
)

deploydocs(
    repo = "github.com/dglmoore/Neet.jl.git"
)
