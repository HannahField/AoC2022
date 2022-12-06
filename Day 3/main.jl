using FileIO

data = open("input.txt", "r")

data = read(data, String)
data = strip(data)


#1

array_data = split(data, "\r\n")
rucksack_front = map(x -> x[1:Int(length(x)/2)],array_data)
rucksack_back = map(x -> x[1+Int(length(x)/2):end],array_data)


appears_in_both = intersect.(rucksack_front,rucksack_back)

function letter_priority(letter)
    lower_case = 'a':'z'
    upper_case = 'A':'Z'
    
    lower_case_zerod = Int('a') - 1
    upper_case_zerod = Int('A') - 27
    if (letter in lower_case)
        return Int(letter) - lower_case_zerod
    elseif (letter in upper_case)
        return Int(letter) - upper_case_zerod
    else
        return nothing
    end
end
priority_list = letter_priority.(map(only,appears_in_both))
priority_sum = sum(priority_list)
println(priority_sum)
#2
grouped_data = []
for i in 1:length(array_data)/3
    i = Int(i)
    push!(grouped_data,collect(String,array_data[(1+(i-1)*3):3+(i-1)*3]))
end
appears_in_all_3 = map(x -> intersect(x...),grouped_data)
priority_list_2 = letter_priority.(map(only,appears_in_all_3))
priority_sum_2 = sum(priority_list_2)
println(priority_sum_2)