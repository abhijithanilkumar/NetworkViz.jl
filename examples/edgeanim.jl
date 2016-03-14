# Edge Animation

using ThreeJS
using NetworkViz
using LightGraphs

main(window) =  begin
    g = Graph(10)
    push!(window.assets,("ThreeJS","threejs"))
    fps1 = fps(1)
    frames = foldp(+, 1, map((x)->1, fps1))
    running = map(x->x<9, frames)
    map(fpswhen(running, 1)) do _
        addEdge(g,frames.value,frames.value+1,1)
    end
end
