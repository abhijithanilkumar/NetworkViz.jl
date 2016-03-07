using ThreeJS
using Compat

main(window) = begin
    push!(window.assets,("ThreeJS","threejs"))
    vbox(
        title(2,"ThreeJS"),
        outerdiv() <<
        (
        initscene() <<
        [
            mesh(0.0, 0.0, 0.0) <<
                [
                    ThreeJS.box(1.0, 1.0, 1.0),
                    material(Dict(:kind=>"lambert",:color=>"red"))
                ],
            pointlight(3.0, 3.0, 3.0),
            camera(0.0, 0.0, 10.0)
        ]
        )
    )
end
