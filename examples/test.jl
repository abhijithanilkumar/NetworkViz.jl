#Run this in Escher to visualize a WheelGraph

using LightGraphs
using NetworkViz
using ThreeJS

main(window) = begin
    num = Input(10)
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
        vbox(
        "WheelGraph Example",
        vskip(2em),
        vbox(
            "Number of Nodes",
            slider(10:100) >>> num
        ),
        lift(num) do n
            drawwheel2D(n)
        end
        ) |> pad(2em)
end
