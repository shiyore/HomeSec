import HTTP
import JSON

# Testing basic REST
r = HTTP.request("GET", "http://dummy.restapiexample.com/api/v1/employees", verbose=3)
println(r.status)
println(JSON.parse(String(r.body)))

println()

# Testing Code Verification
keypad = Keypad(
    Sensor("UTest Keypad",
           1,
           keypad_type
    ),
    ""
)

entercode(keypad, "123456")
r = HTTP.request("GET", sendsignal(), verbose=3)
println(r.status)
println(JSON.parse(string(r.body)))

entercode(keypad, "110199")
r = HTTP.request("GET", sendsignal(), verbose=3)
println(r.status)
println(JSON.parse(string(r.body)))

entercode(keypad, "654321")
r = HTTP.request("GET", sendsignal(), verbose=3)
println(r.status)
println(JSON.parse(string(r.body)))

# Testing alarm status
r = HTTP.request("GET",  "http://localhost:8080/HomeSec/rest/API/alarmStatus", verbose=3)
println(r.status)
println(JSON.parse(string(r.body)))

r = HTTP.request("POST", "http://localhost:8080/HomeSec/rest/API/sensorTrip/03/FrontDoor/movement_type/false", verbose=3)
println(r.status)
println(JSON.parse(string(r.body)))

r = HTTP.request("GET",  "http://localhost:8080/HomeSec/rest/API/alarmStatus", verbose=3)
println(r.status)
println(JSON.parse(string(r.body)))