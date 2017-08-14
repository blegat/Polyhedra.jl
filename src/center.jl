export hchebyshevcenter, vchebyshevcenter, chebyshevcenter
using JuMP
"""
    hchebyshevcenter(p::HRep[, solver])

Return a tuple with the center and radius of the largest euclidean ball contained in the polyhedron `p`.
Throws an error if the polyhedron is empty or if the radius is infinite.
"""
function hchebyshevcenter(p::HRep{N}, solver=defaultLPsolverfor(p, solver)) where N
    m = Model(solver=solver)
    r = @variable m r >= 0
    c = @variable m [1:N]
    for hp in eqs(p)
        a = Vector{Float64}(hp.a)
        β = Float64(hp.β)
        @constraint m dot(a, c) == β
    end
    for hs in ineqs(p)
        a = Vector{Float64}(hs.a)
        β = Float64(hs.β)
        @constraint m dot(a, c) + r * norm(a, 2) <= β
    end
    @objective m Max r
    status = solve(m)
    if status != :Optimal
        if status == :Infeasible
            error("An empty polyhedron has no H-Chebyshev center")
        elseif status == :Unbounded
            error("The polyhedron contains euclidean ball of arbitrary large radius")
        else
            error("Solver returned $status when computing the H-Chebyshev center")
        end
    end
    (getvalue(c), getvalue(r))
end

# TODO defaultLPsolverfor here should not be SimpleVRepSolver
"""
    vchebyshevcenter(p::VRep[, solver])

Return a tuple with the center and radius of the smallest euclidean ball containing the polyhedron `p`.
Throws an error if the polyhedron is empty or if the radius is infinite (i.e. `p` is not a polytope, it contains rays).
"""
function vchebyshevcenter(p::VRep, solver=defaultLPsolverfor(p, solver))
    error("TODO")
end

"""
    chebyshevcenter(p::Rep[, solver])

If `p` is a H-representation or is a polyhedron for which the H-representation has already been computed, calls `hchebyshevcenter`, otherwise, call `vchebyshevcenter`.
"""
function chebyshevcenter(p::Polyhedron, solver=defaultLPsolverfor(p))
    if hrepiscomputed(p)
        hchebyshevcenter(p, solver)
    else
        vchebyshevcenter(p, solver)
    end
end
chebyshevcenter(p::HRepresentation, solver=defaultLPsolverfor(p)) = hchebyshevcenter(p, solver)
chebyshevcenter(p::VRepresentation, solver=defaultLPsolverfor(p)) = vchebyshevcenter(p, solver)
