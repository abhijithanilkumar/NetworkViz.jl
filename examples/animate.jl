#Run this in Escher to see a growing Complete Graph in the browser.


import ThreeJS

main(window) =  begin
    push!(window.assets,("ThreeJS","threejs"))
    eventloop = every(1/60)
    n = 2
    map(eventloop) do _
        n += 1
        if n == 100
          break
        end
        drawWheel(n,1)
    end
end
