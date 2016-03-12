module NetworkViz

# package code goes here
    using ThreeJS

    export layout_spring
    include("spring.jl")

    export find_edges
    export drawWheel
    export drawGraph
    export addEdge
    export removeEdge
    export addNode
    export removeNode
    include("utils.jl")

end # module
