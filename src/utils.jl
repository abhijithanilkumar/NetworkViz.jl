using NetworkViz
using LightGraphs

function find_edges(loc_x,loc_y,loc_z,adj_matrix)

    size(adj_matrix, 1) != size(adj_matrix, 2) && error("Adj. matrix must be square.")
    vertices = Tuple{Float64, Float64, Float64}[]
    const N = length(loc_x)
    for i = 1:N
        for j = 1:N
            i == j && continue
            if adj_matrix[i,j] != zero(eltype(adj_matrix))
                push!(vertices, (loc_x[i],loc_y[i],loc_z[i]), (loc_x[j],loc_y[j],loc_z[j]))
            end
        end
    end
    return vertices
end

function drawwheel(num::Int)
  g = WheelGraph(num); am = full(adjacency_matrix(g))
  loc_x, loc_y, loc_z = layout_spring_adj(am)
  pts = zip(loc_x,loc_y,loc_z)
  vertices = find_edges(loc_x, loc_y, loc_z, am)
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
      ThreeJS.line(vertices,kind="pieces") <<
      [
          ThreeJS.linematerial(Dict(:color=>"yellow"))
      ],
      pointlight(3.0, 3.0, 3.0),
      camera(0.0, 0.0, 5.0)
  ]
  )
end
