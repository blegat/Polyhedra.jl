using Polyhedra
using Base.Test

A = [1 1; -1 0; 0 -1]
b = [1, 0, 0]
linset = IntSet([1])

@test_throws ErrorException InequalityDescription(A, [0, 0], linset)
@test_throws ErrorException InequalityDescription(A, [0, 0], IntSet([4]))
ine = InequalityDescription(A, b, linset)
@test fulldim(ine) == 2
@test eltype(ine) == Int

V = [0 1; 1 0]
vertex = IntSet([1, 2])
@test_throws ErrorException GeneratorDescription(V, [1 0 0], vertex, IntSet([]), IntSet([]))
@test_throws ErrorException GeneratorDescription(V, [1 1], vertex, IntSet([]), IntSet([2]))
@test_throws ErrorException GeneratorDescription(V, [1 1], vertex, IntSet([4]), IntSet([]))
@test_throws ErrorException GeneratorDescription(V, IntSet([4]))
ext = GeneratorDescription(V, vertex)
@test fulldim(ext) == 2
@test eltype(ext) == Int