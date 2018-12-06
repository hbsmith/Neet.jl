export AbstractNetwork, update!, update, statespace, neighbors

"""
    AbstractNetwork

A supertype for all network types.

To implement the `AbstractNetwork` interface, a concrete subtype must provide
the following methods:

* [`update!(net, dest, state)`](@ref)
* [`statespace(net)`](@ref)
* [`neighbors(net, node, dir)`](@ref)

The following methods have default definitions which are usually sufficient.

* [`Base.size(net)`](@ref) - if `net` has as `size` property
* [`update!(net, state)`](@ref) - if `update!(net, state, state)` is well-behaved
* [`neighbors(net, nodes, dir)`](@ref)
* [`neighbors(net, dir)`](@ref)

"""
abstract type AbstractNetwork end

"""
    size(net::AbstractNetwork)

Return the number of nodes in `net`.

**Note**: Concrete network subtypes need not define this method if they have a
`size` property.
"""
Base.size(net::AbstractNetwork) = net.size

"""
    update!(net::AbstractNetwork, dest::AbstractVector, state::AbstractVector)
    update!(net::AbstractNetwork, state::AbstractVector)

Update a `state` according to the network rules specified by `net`, and store
the result in `dest`. If `dest` is not provided, the state is updated in place.
The updated state is returned.

Typically `dest` must be at least as large as `state`; however, that may vary
depending on the concrete network subtype.

**Note**: Concrete network subtypes _must_ define `update!(net, dest, state)`.
If it is safe to call `update!(net, state, state)`, then `update!(net, state)`
need not be overloaded (as that is the default definition).
"""
@unimpl update!(net::AbstractNetwork, dest::AbstractVector, state::AbstractVector)

update!(net::AbstractNetwork, state::AbstractVector) = update!(net, state, state)

"""
    update(net::AbstractNetwork, state)

Update a `state` according to the network rules specified by `net`, returning
the result and leaving `state` unmodified.

**Note**: Concrete network subtypes rarely need to overload this method as a
default implementation is provided based on [`update!(net, dest,
state)`](@ref). The exception to this rule is if the size or type of `dest` is
not the same as `state` for the particular concrete network subtype.
"""
update(net::AbstractNetwork, state::AbstractVector) = update!(net, deepcopy(state), state)

"""
    statespace(net::AbstractNetwork)

Return an `AbstractStateSpace` representing the state space of `net`.

**Note**: Concrete network subtypes _must_ define this method.
"""
@unimpl statespace(net::AbstractNetwork)

"""
    neighbors(net::AbstractNetwork, node::Int[, dir::Symbol=:inout])

Return an array of the indicies of nodes of `net` which neighbor `node`. If
`dir` is provided it must be one of

* `:in` - only return sources of edges incoming to `node`
* `:out` - only return targets of edges outgoing from `node`
* `:inout` - return all neighbors (`:in` and/or `:out`) of `node`

**Note**: Concrete network subtypes _must_ define this method.
"""
@unimpl neighbors(net::AbstractNetwork, node::Int, dir::Symbol=:inout)

"""
    neighbors(net::AbstractNetwork, nodes[, dir::Symbol=:inout])

Return a collection of arrays of neighboring nodes, one for each node in the
`nodes` collection. If `dir` is provided it must be one of `:in:`, `:out`, or
`:inout`.

**Note**: Concrete network subtypes should rarely need define this method.
"""
function neighbors(net::AbstractNetwork, nodes, dir::Symbol=:inout)
    neighbors.(net, nodes, dir)
end

"""
    neighbors(net::AbstractNetwork[, dir::Symbol=:inout])

Return a vector of arrays of neighboring nodes, one for each node in `net`. If
`dir` is provided it must be one of `:in:`, `:out`, or `:inout`.

**Note**: Concrete network subtypes should rarely need define this method.
"""
neighbors(net::AbstractNetwork, dir::Symbol=:inout) = neighbors.(net, 1:size(net), dir)
