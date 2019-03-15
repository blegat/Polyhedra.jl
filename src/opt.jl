export AbstractPolyhedraOptimizer

abstract type AbstractPolyhedraOptimizer <: MOI.AbstractOptimizer end

struct FeasibilitySet <: MOI.AbstractModelAttribute end

function MOI.copy_to(dest::AbstractPolyhedraOptimizer,
                     src::MOI.ModelLike)
    MOI.empty!(dest)

    idxmap = IndexMap()

    vis_src = MOI.get(src, MOI.ListOfVariableIndices())
    vis_dest = MOI.add_variable(dest, length(vis_src))
    for (vi_src, vi_dest) in zip(vis_src, vis_dest)
        idxmap.varmap[vi_src] = vi_dest
    end

    # Copy variable attributes
    pass_attributes(dest, src, copy_names, idxmap, vis_src)

    # Copy model attributes
    pass_attributes(dest, src, copy_names, idxmap)

    lphrep = LPHRep(src)
    if hashreps(lphrep)
        MOI.set(dest, MOI.FeasibilitySet(), lphrep)
    end

    return idxmap
end

# see the cheat in lpqp_to_polyhedra
#function PolyhedraModel(solver::Solver)
#  error("PolyhedraModel not implemented for solver $solver")
#end

#creates ambiguity with (::VRepMode, ::Vrep) when a polyhedron is given
#loadproblem!(m::AbstractPolyhedraModel, hrep::HRep, c, sense) = error("loadproblem! not implemented")

struct LinprogSolution
    status
    objval
    sol
    attrs
end

"""
    linprog(c::AbstractVector, p::Rep, solver::MathProgBase.AbstractMathProgSolver=Polyhedra.solver(p))

Solve the minimization of the objective ``\\langle c, x \\rangle`` over the polyhedron `p`.
"""
function MPB.linprog(c::AbstractVector, p::Rep, solver::Solver=Polyhedra.solver(p))
    m = PolyhedraModel(solver)
    if fulldim(p) != length(c)
        throw(DimensionMismatch("length of objective does not match dimension of polyhedron"))
    end
    MPBSI.loadproblem!(m, p, c, :Min)
    MPBSI.optimize!(m)
    stat = MPBSI.status(m)
    if stat == :Optimal
        return LinprogSolution(stat, MPBSI.getobjval(m), MPBSI.getsolution(m), Dict())
    elseif stat == :Unbounded
        attrs = Dict()
        try
            attrs[:unboundedray] = MPBSI.getunboundedray(m)
        catch
            @warn "Problem is unbounded, but unbounded ray is unavailable; check that the proper solver options are set."
        end
        return LinprogSolution(stat, nothing, [], attrs)
    else
        return LinprogSolution(stat, nothing, [], Dict())
    end
end

"""
    isempty(p::Rep, solver::MathProgBase.AbstractMathProgSolver=Polyhedra.solver(p))

Check whether the polyhedron `p` is empty by using the solver `solver`.
"""
function Base.isempty(p::Rep{T}, solver::Solver=Polyhedra.solver(p)) where {T}
    N = fulldim(p)
    if N == -1
        if p isa VRepresentation || (p isa Polyhedron && fulldim(vrep(p)) == -1)
            # Empty V-representation means empty polyhedron
            return true
        else
            # Empty H-representation means the polyhedron the full space
            return false
        end
    end
    return MPB.linprog(zeros(T, fulldim(p)), p, solver).status == :Infeasible
end
