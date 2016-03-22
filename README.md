## NetworkViz
Linux, OSX : [![Build Status](https://travis-ci.org/abhijithanilkumar/NetworkViz.jl.svg?branch=master)](https://travis-ci.org/abhijithanilkumar/NetworkViz.jl)

Windows : [![Build status](https://ci.appveyor.com/api/projects/status/c7ktq0w08yq281gt/branch/master?svg=true)](https://ci.appveyor.com/project/abhijithanilkumar/networkviz-jl/branch/master)

A Julia module to render graphs in 3D using [ThreeJS](https://github.com/rohitvarkey/ThreeJS.jl) tightly coupled with [LightGraphs](https://github.com/JuliaGraphs/LightGraphs.jl).

### Install

In a Julia REPL, run:

```julia
Pkg.add("NetworkViz")
```
### Graph Algorithms Used

* [Force Directed Placement](http://emr.cs.iit.edu/~reingold/force-directed.pdf)

### Visualizing Graphs

The `drawGraph` function can be used to draw the graphs in 2D or 3D with nodes having different colors. It can accept `LightGraphs.Graph` and `LightGraphs.Digraph` types. `drawGraph` can be used to draw graphs from adjacency matrices also. The function accepts an additional kwargs `z` and `color`. If `z=1`, it draws a 3D graph. If `z=0`, a 2D visualization of the graph is drawn. `color` is an array of node colors.

Usage :
```julia
g = CompleteGraph(10)
drawGraph(g,z=1) #Draw using a Graph object (3D).
am = full(adjacency_matrix(g))
drawGraph(am,z=0) #Draw using an adjacency matrix (2D).

dgraph = bfs_tree(g,1)
drawGraph(dgraph,z=1) #Draw a Digraph.
```
### Utility Functions

* `addEdge(g::Graph,node1::Int,node2::Int,z=1)` - Add a new edge `node1-node2` and redraws the graph. `z` toggles 2D-3D conversion. Fails silently if an already existing node is added again.
* `removeEdge(g::Graph,node1::Int,node2::Int,z=1)` - Removes the edge `node1-node2` if it exists and redraws the graph. `z` toggles 2D-3D conversion.
* `addNode(g::Graph,z=1)` - Adds a new node to the graph. `z` toggles 2D-3D conversion.
* `removeNode(g::Graph,node::Int,z=1)` - Removes `node` if it exists and redraws the graph. `z` toggles 2D-3D conversion.

### Examples

```julia
using LightGraphs
using NetworkViz
using ThreeJS

main(window) = begin
    num = Signal(10)

    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
        vbox(
        h1("WheelGraph Example"),
        vskip(2em),
        vbox(
            "Number of Nodes",
            slider(10:100) >>> num
        ),
        vskip(2em),

        map(num) do n
            g = WheelGraph(n)
            drawGraph(g,z=1)
        end
        ) |> pad(2em)
end
```

The above example when run in Escher shows the visualization of a `WheelGraph` based on input from the slider. The working demo can be seen [here](https://youtu.be/qd8LmY2XBHg).


[Here](https://github.com/abhijithanilkumar/NetworkViz.jl/blob/master/examples/codemirror.jl) is another example with a code-mirror where functions can be typed in. Depending on the LightGraphs function used, 2D as well as 3D graphs are drawn. You can see the working demo [here](https://www.youtube.com/watch?v=Ac3cneCRTZo).

You can find many other examples in the `examples/` folder.

### Acknowledgement

[IainNZ](https://github.com/IainNZ) for the original Spring-Embedder code. (Taken from [GraphLayout.jl](https://github.com/IainNZ/GraphLayout.jl/blob/master/src/spring.jl)).
