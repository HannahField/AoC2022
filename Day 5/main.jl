using FileIO

data = open("input.txt", "r")
data = read(data, String)

starting_arrangement, move_set = split(data, "\r\n\r\n")
starting_arrangement = split(starting_arrangement, "\r\n")
box_arrangement = []
for i = eachindex(starting_arrangement[1:end])
    temp_array = []
    for j = eachindex(starting_arrangement[i])
        if (j % 4 == 2)
            append!(temp_array, starting_arrangement[i][j])
        end
    end
    push!(box_arrangement, temp_array)
end
box_arrangement = permutedims(mapreduce(permutedims, vcat, box_arrangement))[:, end:-1:1]
box_arrangement = [box_arrangement[i, :] for i in eachindex(box_arrangement[1, :])]
box_arrangement = map(x -> filter(y -> y != ' ', x), box_arrangement)

move_set = split(strip(move_set), "\r\n")
move_set = map(x -> replace(x, "move " => ""), move_set)
move_set = map(x -> replace(x, "from " => ""), move_set)
move_set = map(x -> replace(x, "to " => ""), move_set)
move_set = map(x -> split(x, " "), move_set)
move_set = map(x -> map(y -> parse(Int, y), x), move_set)

#1
function push_pop_moves(moves,boxes)
    boxes = deepcopy(boxes)
    for i = eachindex(moves)
        number_of_moves = moves[i][1]
        from = moves[i][2]
        to = moves[i][3]
        for n = 1:number_of_moves
            push!(boxes[to], pop!(boxes[from]))
        end
    end
    return boxes
end
println(map(x -> push_pop_moves(move_set,box_arrangement)[x][end],1:9))
#2

function stack_movement(moves,boxes)
    boxes = deepcopy(boxes)
    for i = eachindex(moves)
        number_of_moves = moves[i][1]
        from = moves[i][2]
        to = moves[i][3]

        append!(boxes[to], boxes[from][end-number_of_moves+1:end])
        for n = 1:number_of_moves
            pop!(boxes[from])
        end
    end
    return boxes
end
println(map(x -> stack_movement(move_set,box_arrangement)[x][end],1:9))