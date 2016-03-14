# Example to demonstrate the use of a codemirror. 

using ThreeJS
using Colors: colormap
using LightGraphs
using NetworkViz


g = Graph(10)

function surf(f::Function)
 ThreeJS.outerdiv() <<
            (ThreeJS.initscene() <<
                [
                    ThreeJS.mesh(0.0, 0.0, 0.0) <<
                    [
                        ThreeJS.parametric(100,100,-10:10, -10:10,f),
                        ThreeJS.material(Dict(:kind=>"lambert",:color=>"white",
                        :colorkind=>"vertex"));
                    ],
                    ThreeJS.ambientlight(),
                    ThreeJS.camera(30.0, 30.0, 30.0)
                ]
            )
end

function mesh(f::Function)
 ThreeJS.outerdiv() <<
            (ThreeJS.initscene() <<
                [
                    ThreeJS.meshlines(50, 50, -10:10, -10:10, f),
                    ThreeJS.ambientlight(),
                    ThreeJS.camera(30.0, 30.0, 30.0);
                ]
            )
end
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
