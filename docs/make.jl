using Documenter
using Neet

makedocs(
    sitename = "Neet",
    format = :html,
    modules = [Neet]
)

deploydocs(
    repo = "github.com/dglmoore/Neet.jl.git"
)
