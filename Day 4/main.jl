using FileIO

data = open("input.txt","r")
data = read(data, String)
data = strip(data)
array_data = map(x -> [split(x[1],"-"),split(x[2],"-")],map(x-> split(x,","),split(data, "\r\n")))
#1
function is_within(ranges) 
    return (ranges[1][1] <= ranges[2][1] && ranges[1][2] >= ranges[2][2]) || (ranges[1][1] >= ranges[2][1] && ranges[1][2] <= ranges[2][2])
end
int_array = map(x -> map(y -> map(z -> parse(Int,z),y),x),array_data)
println(int_array)
println(count(map(is_within,int_array)))
#2
function has_any_overlap(ranges) 
    return (ranges[1][2] >= ranges[2][1] && ranges[1][1] <= ranges[2][2]) || (ranges[2][1] >= ranges[1][2] && ranges[1][1] >= ranges[2][2])
end
println(count(map(has_any_overlap,int_array)))