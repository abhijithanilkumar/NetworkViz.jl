using LightGraphs
using NetworkViz
using ThreeJS

g = WheelGraph(500); am = full(adjacency_matrix(g))
loc_x, loc_y, loc_z = layout_spring_adj(am)
print(loc_x)
print(loc_y)
print(loc_z)
i=1
mesh = [(loc_x[i],loc_y[i],loc_z[i]) for i=1:10]
pts = zip(loc_x,loc_y,loc_z)
vertices = Tuple{Float64, Float64, Float64}[(loc_x[i],loc_y[i],loc_z[i]) for i in 1:500]
@show size(loc_x)

main(window) = begin
    push!(window.assets,("ThreeJS","threejs"))
        outerdiv() <<
        (
        initscene() <<
        [
            ThreeJS.pointcloud(collect(pts)) <<
            [
              ThreeJS.pointmaterial(Dict(
              :color=>"blue",
              :size=>0.05
              ))
            ],
            ThreeJS.line(vertices) <<
            [
                ThreeJS.linematerial(Dict(:color=>"yellow"))
            ],
            pointlight(3.0, 3.0, 3.0),
            camera(0.0, 0.0, 10.0)
        ]
        )
end
