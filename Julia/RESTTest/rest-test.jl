import HTTP
import JSON

r = HTTP.request("GET", "http://dummy.restapiexample.com/api/v1/employees"; verbose=3)
println(r.status)
println(JSON.parse(String(r.body)))