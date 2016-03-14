#Run this in Escher to visualize a WheelGraph

using LightGraphs
using NetworkViz
using ThreeJS

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
            drawGraph(g,1)
        end
        ) |> pad(2em)
end
