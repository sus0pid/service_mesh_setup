#!/bin/sh

# Run wrk with 1 thread, 1 connection, for 5 seconds on IP address
echo "Running test 1: http://20.1.243.152:80"
wrk -t1 -c1 -d5s http://20.1.243.152:80

# Wait for 3 minutes (180 seconds)
sleep 5

# Run wrk with 1 thread, 1 connection, for 5 seconds on service DNS
echo "Running test 2: http://httpbin-istio-telemetry-service.istio-telemetry.svc.cluster.local:80"
wrk -t1 -c1 -d5s http://httpbin-istio-telemetry-service.istio-telemetry.svc.cluster.local:80

# Wait for 3 minutes (180 seconds)
sleep 5

# Run wrk with 12 threads, 400 connections, for 30 seconds on IP address
echo "Running test 3: http://20.1.243.152:80"
wrk -t12 -c400 -d30s http://20.1.243.152:80

# Wait for 3 minutes (180 seconds)
sleep 5

# Run wrk with 12 threads, 400 connections, for 30 seconds on service DNS
echo "Running test 4: http://httpbin-istio-telemetry-service.istio-telemetry.svc.cluster.local:80"
wrk -t12 -c400 -d30s http://httpbin-istio-telemetry-service.istio-telemetry.svc.cluster.local:80

echo "All tests completed."

