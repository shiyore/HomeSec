import JSON
import HTTP

using Printf

base_link = "http://localhost:8080/HomeSec/rest/API/"

include("sensortypes.jl")

# Will actually send the signal and return the response in the future
# This is purely temporary for testing purposes
function sendsignal(s::AbstractString)
    return s
end

function sendsignal(s::MotionSensor)
    link = string(base_link, "sensorTrip/", string(s.data.id), "/", replace(string(Dates.now()), "T" => " "), "/", string(s.d_feet))
end

function sendsignal(s::MovementSensor)
    link = string(base_link, "sensorTrip/", string(s.data.id), "/", replace(string(Dates.now()), "T" => " "), "/", string(s.isopen))
end

function sendsignal(s::Keypad)
    link = string(base_link, "codeCheck/", string(s.data.id), "/", s.code, "/", replace(string(Dates.now()), "T" => " "))
    return JSON.parse(HTTP.request("GET", sendsignal(link)))["ValidCode"]
end

function detectmotion(s::MotionSensor, d_feet::Float64)
    s.d_feet = d_feet
    return sendsignal(s)
end

function alarm_is_on()
    return JSON.parse(HTTP.request("GET",  string(base_link, "alarmStatus")))["AlarmTripped"]
end

function open(s::MovementSensor)
    s.isopen = true
    return sendsignal(s)
end

function close(s::MovementSensor)
    s.isopen = false
    return sendsignal(s)
end

function entercode(s::Keypad, code::AbstractString)
    s.code = code
    return s
end

function utest()
    motion = MotionSensor(
                Sensor("UTest Motion Sensor",
                       1,
                       motion_type
                ),
                0.00
    )

    movement = MovementSensor(
                Sensor("UTest Movement Sensor",
                       2,
                       movement_type
                ),
                false
    )

    keypad = Keypad(
                Sensor("UTest Keypad",
                       3,
                       keypad_type
                ),
                ""
    )

    println("Unit testing on JSON")
    println()

    println(sendsignal(motion))
    #@assert sendsignal(motion)   == """{"data":{"name":"UTest Motion Sensor","id":1,"type":"motion_type"},"d_feet":0.0}"""

    println(sendsignal(movement))
    #@assert sendsignal(movement) == """{"data":{"name":"UTest Movement Sensor","id":2,"type":"movement_type"},"isopen":false}"""

    println(sendsignal(keypad))
    #@assert sendsignal(keypad)   == """{"data":{"name":"UTest Keypad","id":3,"type":"keypad_type"},"code":""}"""

    println()
    println("Testing procedures")
    println()

    println("Detecting motion 10 feet away")
    detectmotion(motion, 10.0)
    println()

    println("Detecting sensor opening")
    open(movement)
    println()

    println("Detecting door closing")
    close(movement)
    println()

    println("Entering code 1101")
    entercode(keypad, "1101")
end

utest()