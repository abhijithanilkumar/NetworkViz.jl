#Run this in Escher to visualize a WheelGraph

using LightGraphs
using NetworkViz
using ThreeJS
using Colors

main(window) = begin
    num = Signal(10)
    toggle = Signal(false)

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
        vbox(
            "2D/3D",
            hskip(2em),
            togglebutton() >>> toggle
        ),
        vskip(2em),

        map(toggle,num) do t,n
            g = WheelGraph(n)
            c = distinguishable_colors(nv(g))
            drawGraph(g,c,t)
        end
        ) |> pad(2em)
end
