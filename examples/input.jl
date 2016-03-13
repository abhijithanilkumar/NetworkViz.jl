#Run this in Escher to visualize a WheelGraph

using LightGraphs
using NetworkViz
using ThreeJS
using Escher

main(window) = begin
  push!(window.assets, "widgets")
  push!(window.assets,("ThreeJS","threejs"))

  inp = Signal(Dict{Any, Any}(:name=>"10"))

  s = Escher.sampler()
  form = vbox(
      h1("Number of Nodes"),
      watch!(s, :name, textinput("", label="Nodes")),
      trigger!(s, :submit, button("Submit"))
  ) |> maxwidth(400px)

  map(inp) do dict
      num = parse(Int,dict[:name])
      vbox(
          intent(s, form) >>> inp,
          vskip(2em),
          drawWheel(num,1)
      ) |> Escher.pad(2em)
  end
end
