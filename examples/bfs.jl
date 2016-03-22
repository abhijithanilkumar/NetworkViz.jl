# Breadth First Search Example

using ThreeJS
using Escher
using LightGraphs
using NetworkViz

main(window) = begin
    push!(window.assets, "widgets")
    push!(window.assets,("ThreeJS","threejs"))
    nodes = Signal(10)
    btn = Signal(Any, leftbutton)
    start = Signal(false)
    map(btn) do _
      push!(start,!start.value)
    end
    map(start,nodes,sampleon(btn,nodes)) do t,n1,n2
    vbox(
        vbox(
          h1("Breadth-First Traversal"),
          vskip(2em),
          "Number of Nodes",
          slider(10:100,disabled=!t) >>> nodes,
          vskip(2em),
          hbox(
            hskip(4em),
            button("Draw",disabled=!t) >>> btn
          )
        ) |> pad(2em),
        hbox(
          hskip(2em),
          vbox(
            if t
              vbox(
                md"""## Original Graph""",
                drawGraph(CompleteGraph(n1),z=1)
              )
            else
              vbox(
                md"""## BFS Traversal of the Graph""",
                drawGraph(bfs_tree(CompleteGraph(n2),1),z=1)
              )
            end
          )
        )
      )
  end
end
