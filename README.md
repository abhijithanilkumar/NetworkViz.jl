## NetworkViz
Linux, OSX : [![Build Status](https://travis-ci.org/abhijithanilkumar/NetworkViz.jl.svg)](https://travis-ci.org/abhijithanilkumar/NetworkViz.jl)

A Julia module to render graphs in 3D using [ThreeJS](https://github.com/rohitvarkey/ThreeJS.jl) tightly coupled with [LightGraphs](https://github.com/JuliaGraphs/LightGraphs.jl).

### Install

```julia
Pkg.clone("https://github.com/abhijithanilkumar/NetworkViz.jl")
Pkg.checkout("ThreeJS")
```
### 

### Examples

```julia
using ThreeJS
using LightGraphs
using NetworkViz

g = Graph(10)

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    push!(window.assets,"widgets")
    push!(window.assets, "codemirror")
    push!(window.assets, "layout2")
    default = "g = CompleteGraph(10)"
    inp = Signal(Dict{Any, Any}(:name=>default))
    s = sampler() # A thing that lets you watch widgets/behaviors upon updates to other behaviors
    editor = watch!(s, :code, codemirror(default))
    code_cell = trigger!(s, :submit, keypress("ctrl+enter shift+enter", editor))
    t, plots = wire(
                        tabs(["3D View";"2D View";]),
                        pages(
                        [
                            map(inp) do f
                                fn = get(f,:code,default)
                                eval(parse(fn))
                                drawGraph(g,1)
                            end;
                            map(inp) do f
                                fn = get(f,:code,default)
                                eval(parse(fn))
                                drawGraph(g,0)
                            end;
                        ]
                        ),
                        :tab_channel,
                        :selected
                    )
        plugsampler(s,
        vbox(

                md"""Enter a valid graph function.
                    `ctrl+enter` or `shift+enter` to redraw the plot.
                    Use the mouse the drag, zoom and pan.
                    Try resizing the browser if you cant see a codebox.
                    """,
                code_cell,
                vskip(2em),
                t, plots
            ) |> pad(6em)
   ) >>> inp
end
```
Running the above example should open up a browser with a code-mirror where functions can be typed in. Depending on the LightGraph function used, 2D as well as 3D graphs are drawn. You can see the working demo [here](https://www.youtube.com/watch?v=Ac3cneCRTZo).

You can find many other examples in the `examples/` folder.
