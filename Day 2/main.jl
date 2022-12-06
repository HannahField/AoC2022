using FileIO
using Match

data = open("input.txt", "r")

data = read(data, String)
data = strip(data)

array_data = split(data, "\r\n")
array_data = map(x -> map(only, split(x, " ")), array_data)


better_names = Dict([('X', "Rock"), ('Y', "Paper"), ('Z', "Scissors"), ('A', "Rock"), ('B', "Paper"), ('C', "Scissors")])
#1
play_points = Dict([("Rock", 1), ("Paper", 2), ("Scissors", 3)])

readable_data = map(x -> map(y -> better_names[y], x), array_data)
function fight_points(opponent, player)
    @match [player, opponent] begin
        ["Rock", "Paper"] => 0
        ["Rock", "Scissors"] => 6
        ["Paper", "Rock"] => 6
        ["Paper", "Scissors"] => 0
        ["Scissors", "Rock"] => 0
        ["Scissors", "Paper"] => 6
        _ => 3
    end
end

points = map(x -> play_points[x[2]], readable_data) + map(x -> fight_points(x...), readable_data)
total = sum(points)
#2

better_names_2 = Dict([('X', "Lose"), ('Y', "Tie"), ('Z', "Win"), ('A', "Rock"), ('B', "Paper"), ('C', "Scissors")])
readable_data_2 = map(x -> map(y -> better_names_2[y], x), array_data)
function choose_play(opponent_play, strategy)
    @match [opponent_play, strategy] begin
        [k, "Tie"] => k
        ["Rock", "Lose"] => "Scissors"
        ["Rock", "Win"] => "Paper"
        ["Paper", "Lose"] => "Rock"
        ["Paper", "Win"] => "Scissors"
        ["Scissors", "Lose"] => "Paper"
        ["Scissors", "Win"] => "Rock"
    end
end
fight_points_2 = Dict([("Lose", 0), ("Tie", 3), ("Win", 6)])
chosen_plays = map(x -> choose_play(x...), readable_data_2)
points_2 = map(x -> play_points[x], chosen_plays) .+ map(x -> fight_points_2[x[2]], readable_data_2)
total_2 = sum(points_2)
println(total_2)