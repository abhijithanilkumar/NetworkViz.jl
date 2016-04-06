module NetworkViz
using ThreeJS

    export NodeProperty, EdgeProperty

    type NodeProperty
      color
      size
      shape
    end

    type EdgeProperty
      color
      width
    end

    NodeProperty(c) = NodeProperty(color=c,size=0.2,shape=0)
    NodeProperty(c,s) = NodeProperty(color=c,size=s,shape=0)

    include("spring.jl")
    include("utils.jl")

end
