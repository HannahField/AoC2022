using FileIO

abstract type Node
end
mutable struct Dir<:Node
    name::String
    entries::Vector{Node}
    parent::Union{Dir,Nothing}
end
mutable struct File <:Node
    name::String
    size::Int32
    parent::Dir
end



data = open("input.txt","r")
data = read(data, String)
data = strip(data)

array_data = split(data,'$'*' ')
array_data = filter(x-> !(x == ""),array_data)

function parse_data(datas::AbstractString)
    datas = deepcopy(datas)
    datas = strip(datas)
    if datas[1:2] == "ls"
        return filter(x -> !(x == ""),split(datas,"\r\n"))
    elseif datas[1:4] == "cd /"
        return ["root"]
    elseif datas[1:5] == "cd .."
        return ["back"]
    elseif datas[1:2] == "cd"
        return filter(x -> !(x == ""),split(datas," "))
    end
end

array_data = parse_data.(array_data)
array_data = array_data[2:end]
root_node = Dir("root",[],nothing)

function populate_tree(current_dir::Dir,instructions::Iterators.Stateful)
    if isempty(instructions)
        return
    end
    instruction = popfirst!(instructions)
    if instruction[1] == "ls"
        instruction = map(x -> split(x," "),instruction[2:end])
            for x in instruction
                if x[1] == "dir"
                    dir = Dir(x[2],[],current_dir)
                    push!(current_dir.entries,dir)
                else
                    file = File(x[2],parse(Int,x[1]),current_dir)
                    push!(current_dir.entries,file)
                end
            end 
        populate_tree(current_dir,instructions)
    elseif instruction[1] == "cd"
        populate_tree(current_dir.entries[only(findall(x-> x.name == instruction[2],current_dir.entries))],instructions)
    elseif instruction[1] == "back"
        populate_tree(current_dir.parent,instructions)
    end

end
populate_tree(root_node,Iterators.Stateful(array_data))

function weights(file::File)
    return file.size
end
function weights(dir::Dir)
    sum(weights.(dir.entries))
end

small_dirs = []
size_of_all_dirs = []

total_size = weights(root_node)
needed_space = total_size - (70000000-30000000)
println(needed_space)

function file_structure_size_search(dir::Dir)
    for y in filter(x -> x isa Dir,dir.entries)
        if (weights(y) < 100000)
            push!(small_dirs,weights(y))
        end
        file_structure_size_search(y)
    end
end

function file_structure_size_search_big(dir::Dir)
    for y in filter(x -> x isa Dir,dir.entries)
        push!(size_of_all_dirs,weights(y))
        file_structure_size_search_big(y)
    end
end
file_structure_size_search_big(root_node)
file_structure_size_search(root_node)


println(sum(small_dirs))
sort!(size_of_all_dirs)
println(minimum(filter(x -> x > needed_space,size_of_all_dirs)))