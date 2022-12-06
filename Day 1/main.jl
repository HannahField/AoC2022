using FileIO

data = open("input.txt","r")
#1
data = read(data, String)
data = strip(data)
array_data = split(data,"\r\n\r\n")
array_data = map(x -> split(x,"\r\n"), array_data)
elf_total = map(x -> sum(map(y -> parse(Int,y),x)),array_data)
#2

elf_total_sorted = sort(elf_total,rev=true)
n = 3
println(sum(elf_total_sorted[1:n]))