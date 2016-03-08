module NetworkViz

# package code goes here
    using ThreeJS

    export layout_spring_adj
    include("spring.jl")

    export find_edges
    include("utils.jl")

end # module
