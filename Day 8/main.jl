using FileIO

data = open("input.txt", "r")
data = read(data, String)
data = strip(data)

array_data = split(data, "\r\n")
array_data = map(x -> collect(x), array_data)
array_data = map(x -> map(y -> parse(Int, y), x), array_data)
matrix_data = mapreduce(permutedims, vcat, array_data)
#1
function look_in_direction(heights::Matrix{Int})
    visible_trees = 0
    for rows = 1:size(heights)[1]
        for columns = 1:size(heights)[2]
            if (all(x -> x < heights[rows, columns], heights[1:(rows-1), columns]) ||
                all(x -> x < heights[rows, columns], heights[end:-1:(rows+1), columns]) ||
                all(x -> x < heights[rows, columns], heights[rows, 1:(columns-1)]) ||
                all(x -> x < heights[rows, columns], heights[rows, end:-1:(columns+1)]))
                visible_trees += 1
            end
        end
    end
    return visible_trees
end
println(look_in_direction(matrix_data))
#2
function total_scenic_score(heights::Matrix{Int})::Matrix{Int}
    scenic_scores = zeros(size(heights))
    for rows = 1:size(heights)[1]
        for columns = 1:size(heights)[2]
            north_score = scenic_score(heights[rows-1:-1:1,columns],heights[rows,columns])
            east_score = scenic_score(heights[rows,columns+1:end],heights[rows,columns])
            south_score = scenic_score(heights[rows+1:end,columns],heights[rows,columns])
            west_score = scenic_score(heights[rows,columns-1:-1:1],heights[rows,columns])
            scenic_scores[rows,columns] = north_score * east_score * south_score * west_score
        end
    end
    return scenic_scores
end

function scenic_score(heights::Vector{Int},current_height::Int)::Int
    scenic_score = 0
    for height in heights
        scenic_score += 1
        if height >= current_height
            return scenic_score
        end
    end
    return scenic_score
end

println(maximum(total_scenic_score(matrix_data)))