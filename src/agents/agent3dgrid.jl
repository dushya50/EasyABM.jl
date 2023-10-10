


"""
$(TYPEDSIGNATURES)

Creates a single 3d agent with properties specified as keyword arguments. 
Following property names are reserved for some specific agent properties 
    - pos : position
    - vel : velocity
    - shape : shape of agent
    - color : color of agent
    - size : size of agent
    - orientation : orientation of agent
    - `keeps_record_of` : Set of properties that the agent records during time evolution. 
"""
function grid_3d_agent(;pos::Vect{3, Int} =Vect(1,1,1), #GeometryBasics.Vec{3, Int} = GeometryBasics.Vec(1,1,1),#Tuple{Int, Int, Int} =(1,1,1), 
    space_type::Type{P} = Periodic, agent_type::Type{T}=Static,
    kwargs...) where {P<:SType, T<:MType}
    dict_agent = Dict{Symbol, Any}(kwargs)

    if !haskey(dict_agent, :keeps_record_of)
        dict_agent[:_keeps_record_of] = Set{Symbol}([])
    else
        dict_agent[:_keeps_record_of] = dict_agent[:keeps_record_of]
        delete!(dict_agent, :keeps_record_of)
    end
    
    dict_agent[:_extras] = PropDict()
    dict_agent[:_extras]._active = true
    dict_agent[:_extras]._new = true

    return Agent3D{Int, P, T}(1, pos, dict_agent,nothing)
end

"""
$(TYPEDSIGNATURES)

Creates a list of n 2d agents with properties specified as keyword arguments.
"""
function grid_3d_agents(n::Int; pos::Vect{3, Int} =Vect(1,1,1), #GeometryBasics.Vec{3, Int} = GeometryBasics.Vec(1,1,1),#Tuple{Int, Int, Int} =(1,1,1), 
    space_type::Type{P} = Periodic, agent_type::Type{T}=Static,
    kwargs...) where {P<:SType, T<:MType}
    list = Vector{Agent3D{Int, P, T}}()
    for i in 1:n
        agent = grid_3d_agent(;pos=pos, space_type= P, agent_type=T, kwargs...)
        push!(list, agent)
    end
    return list
end






