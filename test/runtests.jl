module NetworkVizTest

using NetworkViz
using Patchwork: Elem
using LightGraphs
using Colors
using BaseTestNext

# write your own tests here

@testset "Test Graph Algorithms" begin
    g = CompleteGraph(10)
    am = full(adjacency_matrix(g))
    @testset "layout_spring" begin
        #2-Dimensional
        loc_x, loc_y, loc_z = layout_spring(am,0)
        @test size(loc_x) == size(loc_y) == size(loc_z)
        @test loc_z == zeros(size(loc_x))
        #3-Dimensional
        loc_x, loc_y, loc_z = layout_spring(am,1)
        @test size(loc_x) == size(loc_y) == size(loc_z)
    end
end

@testset "Test Utility Functions" begin
    g = WheelGraph(10)
    dgraph = bfs_tree(g,1)
    am = full(adjacency_matrix(g))
    colors = distinguishable_colors(nv(g))
    @testset "drawGraph" begin
        #Pass Graphs
        plot = drawGraph(g,z=0)
        @test typeof(plot) == Elem{:xhtml,:div}
        plot = drawGraph(g,z=1)
        @test typeof(plot) == Elem{:xhtml,:div}
        plot = drawGraph(g,color=colors,z=1)
        @test typeof(plot) == Elem{:xhtml,:div}
        #Pass Adjacency Matrix
        plot = drawGraph(am,z=0)
        @test typeof(plot) == Elem{:xhtml,:div}
        plot = drawGraph(am,z=1)
        @test typeof(plot) == Elem{:xhtml,:div}
        plot = drawGraph(am,color=colors,z=1)
        @test typeof(plot) == Elem{:xhtml,:div}
        #Pass Digraph
        plot = drawGraph(dgraph,z=0)
        @test typeof(plot) == Elem{:xhtml,:div}
        plot = drawGraph(dgraph,z=1)
        @test typeof(plot) == Elem{:xhtml,:div}
        plot = drawGraph(dgraph,color=colors,z=1)
        @test typeof(plot) == Elem{:xhtml,:div}
    end
end

end #module
