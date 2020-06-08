@enum SensorType begin
    motion_type
    movement_type
    keypad_type
end

mutable struct Sensor
    name::AbstractString
    id  ::Int
    type::SensorType
end

mutable struct MotionSensor
    data  ::Sensor
    d_feet::Float64
end

mutable struct MovementSensor
    data  ::Sensor
    isopen::Bool
end

mutable struct Keypad
    data::Sensor
    code::AbstractString
end