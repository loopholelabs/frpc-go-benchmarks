#!/bin/bash

ulimit -n 16384

echo "Running Server, binding to $1"
go run server/main.go "$1" &
SERVER_PID=$!
echo "Server started with PID ${SERVER_PID}"

sleep 1

echo "Running Client connecting to $1"

echo "Running 32 Byte Benchmarks"
go run client/main.go "$1" 32 100 100 1 1
go run client/main.go "$1" 32 100 100 2 1
go run client/main.go "$1" 32 100 100 5 1
go run client/main.go "$1" 32 100 100 10 1
go run client/main.go "$1" 32 100 100 100 1
go run client/main.go "$1" 32 100 100 1024 1
go run client/main.go "$1" 32 100 100 4096 1
go run client/main.go "$1" 32 100 100 8192 1

sleep 1

echo "Running 512 Byte Benchmarks"
go run client/main.go "$1" 512 100 10 1 1
go run client/main.go "$1" 512 100 10 2 1
go run client/main.go "$1" 512 100 10 5 1
go run client/main.go "$1" 512 100 10 10 1
go run client/main.go "$1" 512 100 100 100 1
go run client/main.go "$1" 512 100 100 1024 1
go run client/main.go "$1" 512 100 100 4096 1
go run client/main.go "$1" 512 100 100 8192 1

sleep 1

echo "Running 1KB Benchmarks"
go run client/main.go "$1" 131072 100 100 1 1
go run client/main.go "$1" 131072 100 100 2 1
go run client/main.go "$1" 131072 100 100 5 1
go run client/main.go "$1" 131072 100 100 10 1
go run client/main.go "$1" 131072 100 100 100 1

sleep 1

echo "Running 1MB Benchmarks"
go run client/main.go "$1" 1048576 10 10 1 1
go run client/main.go "$1" 1048576 10 10 2 1
go run client/main.go "$1" 1048576 10 10 5 1
go run client/main.go "$1" 1048576 10 10 10 1
go run client/main.go "$1" 1048576 10 10 100 1

sleep 1

echo "Running Concurrent Throughput Benchmarks"
go run client/main.go "$1" 32 100 100 1 10
go run client/main.go "$1" 32 100 100 2 10
go run client/main.go "$1" 32 100 100 5 10
go run client/main.go "$1" 32 100 100 10 10
go run client/main.go "$1" 32 100 100 100 10
go run client/main.go "$1" 32 100 100 1024 10
go run client/main.go "$1" 32 100 100 4096 10
go run client/main.go "$1" 32 100 100 8192 10

kill -9 "${SERVER_PID}"
pkill main
