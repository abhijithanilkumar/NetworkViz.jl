#Run this in Escher to visualize a WheelGraph

using LightGraphs
using NetworkViz
using ThreeJS
using Colors

main(window) = begin
    num = Signal(10)
    width = Signal(1)
    nodesize = Signal(0.2)
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
            c = Color[parse(Colorant,"#00004d") for i in 1:nv(g)]
            n = NodeProperty(c,0.2,1)
            e = EdgeProperty("#ff3333",1)
            drawGraph(g,node=n,edge=e,z=t)
        end
        ) |> pad(2em)
end
