function decompose(lib::PolyhedraLibrary)
    contains(string(typeof(lib)),"LRSLibrary") && return
    V = [-1 -1 1; -1 1 1; 1 -1 1; 1 1 1; 0 1 -1; 1 0 -1; -1 0 -1; 0 -1 -1]
    R = [0 0 1]
    vrep = SimpleVRepresentation(V, R)
    p = polyhedron(vrep, lib)
    @test GeometryTypes.decompose(GeometryTypes.Point{3, Float32}, p) ==
    [GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(1.0,1.0,2.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(1.0,-1.0,2.0),
     GeometryTypes.Point(1.0,1.0,2.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(1.0,0.0,-1.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(-1.0,1.0,2.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(1.0,1.0,2.0),
     GeometryTypes.Point(-1.0,1.0,2.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(1.0,1.0,1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(1.0,0.0,-1.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(1.0,-1.0,2.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,2.0),
     GeometryTypes.Point(1.0,-1.0,2.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,2.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(-1.0,1.0,2.0),
     GeometryTypes.Point(-1.0,-1.0,2.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(-1.0,0.0,-1.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(-1.0,-1.0,1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0),
     GeometryTypes.Point(-1.0,0.0,-1.0),
     GeometryTypes.Point(-1.0,0.0,-1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(-1.0,1.0,1.0),
     GeometryTypes.Point(1.0,0.0,-1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0),
     GeometryTypes.Point(1.0,-1.0,1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0),
     GeometryTypes.Point(1.0,0.0,-1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(0.0,1.0,-1.0),
     GeometryTypes.Point(-1.0,0.0,-1.0),
     GeometryTypes.Point(0.0,-1.0,-1.0)]
    @test GeometryTypes.decompose(GeometryTypes.Face{3, GeometryTypes.OffsetInteger{1, Int}}, p) ==
    [GeometryTypes.Face(2,3,4),
     GeometryTypes.Face(5,6,7),
     GeometryTypes.Face(8,9,10),
     GeometryTypes.Face(11,12,13),
     GeometryTypes.Face(14,15,16),
     GeometryTypes.Face(17,18,19),
     GeometryTypes.Face(20,21,22),
     GeometryTypes.Face(23,24,25),
     GeometryTypes.Face(26,27,28),
     GeometryTypes.Face(29,30,31),
     GeometryTypes.Face(32,33,34),
     GeometryTypes.Face(35,36,37),
     GeometryTypes.Face(38,39,40),
     GeometryTypes.Face(41,42,43),
     GeometryTypes.Face(44,45,46),
     GeometryTypes.Face(47,48,49),
     GeometryTypes.Face(50,51,52),
     GeometryTypes.Face(53,54,55)]
    @test GeometryTypes.decompose(GeometryTypes.Normal{3,Float64}, p) ==
    [GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(1.0,0.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(0.0,1.0,0.0),
     GeometryTypes.Normal(2/3,2/3,-1/3),
     GeometryTypes.Normal(2/3,2/3,-1/3),
     GeometryTypes.Normal(2/3,2/3,-1/3),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(0.0,-1.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-1.0,0.0,0.0),
     GeometryTypes.Normal(-2/3,-2/3,-1/3),
     GeometryTypes.Normal(-2/3,-2/3,-1/3),
     GeometryTypes.Normal(-2/3,-2/3,-1/3),
     GeometryTypes.Normal(-2/3,2/3,-1/3),
     GeometryTypes.Normal(-2/3,2/3,-1/3),
     GeometryTypes.Normal(-2/3,2/3,-1/3),
     GeometryTypes.Normal(2/3,-2/3,-1/3),
     GeometryTypes.Normal(2/3,-2/3,-1/3),
     GeometryTypes.Normal(2/3,-2/3,-1/3),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0),
     GeometryTypes.Normal(0.0,0.0,-1.0)]

end
