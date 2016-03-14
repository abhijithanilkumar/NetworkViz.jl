# Run this in Escher to visualize a Complete Graph with Vertex identification

using LightGraphs
using NetworkViz
using ThreeJS

main(window) = begin
    num = Signal(10)
    toggle = Signal(false)
    g = CompleteGraph(10)

    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
        vbox(
        h1("CompleteGraph Example"),
        vskip(2em),
        drawGraphwithText(g,1)
        ) |> pad(2em)
end
