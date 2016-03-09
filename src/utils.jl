import NetworkViz
using LightGraphs
using GraphLayout

function find_edges{T}(loc_x::Array{Float64,1},loc_y::Array{Float64,1},loc_z::Array{Float64,1},adj_matrix::Array{T,2})

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

function find_edges{T}(loc_x::Array{Float64,1},loc_y::Array{Float64,1},adj_matrix::Array{T,2})

    size(adj_matrix, 1) != size(adj_matrix, 2) && error("Adj. matrix must be square.")
    vertices = Tuple{Float64, Float64, Float64}[]
    const N = length(loc_x)
    for i = 1:N
        for j = 1:N
            i == j && continue
            if adj_matrix[i,j] != zero(eltype(adj_matrix))
                push!(vertices, (loc_x[i],loc_y[i],0), (loc_x[j],loc_y[j],0))
            end
        end
    end
    return vertices
end

function drawwheel3D(num::Int)
    g = WheelGraph(num)
    drawGraph3D(g)
end

function drawGraph3D(g::Graph)
    am = full(adjacency_matrix(g))
    loc_x, loc_y, loc_z = layout_spring_adj_3D(am)
    pts = zip(loc_x,loc_y,loc_z)
    vertices = find_edges(loc_x, loc_y, loc_z, am)
    plot(collect(pts),vertices)
end

function drawwheel2D(num::Int)
    g = WheelGraph(num)
    drawGraph2D(g)
end

function drawGraph2D(g::Graph)
    am = full(adjacency_matrix(g))
    loc_x, loc_y = layout_spring_adj(am)
    loc_z = zeros(size(loc_x))
    pts = zip(loc_x,loc_y,loc_z)
    vertices = find_edges(loc_x, loc_y, am)
    plot(collect(pts),vertices)
end

function addEdge(g::Graph, node1::Int, node2::Int)
    add_edge!(g,node1,node2)
    drawGraph3D(g)
end


function plot{T}(pts::Array{T,1}, vertices::Array{T,1})
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
