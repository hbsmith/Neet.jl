export unimpl

"""
    @unimpl

Implement a function from a signature which raises an error.

# Example

```jldoctest; setup = :(import Neet.@unimpl)
julia> abstract type A end

julia> struct B <: A end

julia> @unimpl foo(a::A)
foo (generic function with 1 method)

julia> foo(B())
ERROR: `foo(a::A)` is not implemented
[...]

julia> foo(b::B) = "works"
foo (generic function with 2 methods)

julia> foo(B())
"works"
```
"""
macro unimpl(func)
    if func.head != :call && func.head != :where
        error("illformed function identifier")
    end
    expr = Expr(:string, "`$(func)` is not implemented")
    :($(esc(func)) = $(esc(error))($(esc(expr))))
end
