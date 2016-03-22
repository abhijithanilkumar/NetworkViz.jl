#Example which demonstrates basic animation


using ThreeJS
using NetworkViz
using LightGraphs

main(window) =  begin
    g = Graph(10)
    push!(window.assets,("ThreeJS","threejs"))
    fps1 = fps(1)
    frames = foldp(+, 1, map((x)->1, fps1))
    running = map(x->x<49, frames)

    vbox(
    map(fpswhen(running, 1)) do _
        drawGraph(WheelGraph(frames.value+1),z=1)
    end
    )
end
