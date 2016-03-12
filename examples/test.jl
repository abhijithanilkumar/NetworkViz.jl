#Run this in Escher to visualize a WheelGraph

using LightGraphs
using NetworkViz
using ThreeJS

main(window) = begin
    num = Input(10)
    toggle = Input(false)
    
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

        lift(toggle,num) do t,n
            if t        
                drawwheel3D(n)
            else
                drawwheel2D(n)
            end
        end
        ) |> pad(2em)
end
