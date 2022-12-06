using FileIO

data = open("input.txt", "r")
data = read(data, String)
data = strip(data)

println(data)
function find_unique_n_chars(datas, n)
    for i = eachindex(datas[1:end-n-1])
        current_set_of_chars = Set(datas[i:i+n-1])
        if length(current_set_of_chars) == n
            println(current_set_of_chars)
            println(datas[i:i+n-1])
            println(i)
            println(i + n - 1)
            return [i+n-1,current_set_of_chars]
            break
        end
    end
end
#1
find_unique_n_chars(data,4)
#2
find_unique_n_chars(data,14)