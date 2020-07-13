import HTTP
import JSON
import Dates

include("../sensortypes.jl")
include("../signals.jl")

# Testing basic REST
r = HTTP.request("GET", "http://dummy.restapiexample.com/api/v1/employees", verbose=3)
println(r.status)
println(JSON.parse(String(r.body)))

println()

# Testing Code Verification
keypad1 = Keypad(
    Sensor("keypad1",
           1,
           keypad_type
    ),
    ""
)

keypad2 = Keypad(
    Sensor("keypad2",
           2,
           keypad_type
    ),
    ""
)

front_door = MovementSensor(
    Sensor("Front Door",
           3,
           movement_type
    ),
    false
)

front_porch = MotionSensor(
    Sensor("Front Porch",
           4,
           motion_type
    ),
    0.00
)

keypad1 = entercode(keypad1, "123456")
println(sendsignal(keypad1))
#r = HTTP.request("GET", sendsignal(), verbose=3)
#println(r.status)
#println(JSON.parse(string(r.body)))

keypad2 = entercode(keypad2, "323415")
println(sendsignal(keypad2))

keypad2 = entercode(keypad2, "110199")
println(sendsignal(keypad2))
#r = HTTP.request("GET", sendsignal(), verbose=3)
#println(r.status)
#println(JSON.parse(string(r.body)))

keypad1 = entercode(keypad1, "123456")
println(sendsignal(keypad1))
#r = HTTP.request("GET", sendsignal(), verbose=3)
#println(r.status)
#println(JSON.parse(string(r.body)))
front_door = open(front_door)
front_porch = detectmotion(front_porch, 10.0)
# Testing alarm status
#r = 
#println(r.status)
#println(JSON.parse(string(r.body)))
println(alarm_is_on())
#r = HTTP.request("POST", "http://localhost:8080/HomeSec/rest/API/sensorTrip/03/FrontDoor/movement_type/false", verbose=3)
#println(r.status)
#println(JSON.parse(string(r.body)))

#r = HTTP.request("GET",  "http://localhost:8080/HomeSec/rest/API/alarmStatus", verbose=3)
#println(r.status)
#println(JSON.parse(string(r.body)))