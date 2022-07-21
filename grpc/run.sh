#!/bin/bash

echo "Running Server, binding to $1"
go run server/main.go "$1" &
SERVER_PID=$!
echo "Server started with PID $SERVER_PID"

sleep 1

echo "Running Client connecting to $1"
go run client/main.go "$1" 32 100 10 1 1
go run client/main.go "$1" 32 100 10 2 1
go run client/main.go "$1" 32 100 10 5 1
go run client/main.go "$1" 32 100 10 10 1
go run client/main.go "$1" 32 100 10 100 1
go run client/main.go "$1" 32 100 10 1024 1
go run client/main.go "$1" 32 100 10 4096 1
go run client/main.go "$1" 32 100 10 8192 1

go run client/main.go "$1" 512 100 10 1 1
go run client/main.go "$1" 512 100 10 2 1
go run client/main.go "$1" 512 100 10 5 1
go run client/main.go "$1" 512 100 10 10 1
go run client/main.go "$1" 512 100 10 100 1
go run client/main.go "$1" 512 100 10 1024 1
go run client/main.go "$1" 512 100 10 4096 1
go run client/main.go "$1" 512 100 10 8192 1

go run client/main.go "$1" 131072 100 10 1 1
go run client/main.go "$1" 131072 100 10 2 1
go run client/main.go "$1" 131072 100 10 5 1
go run client/main.go "$1" 131072 100 10 10 1
go run client/main.go "$1" 131072 100 10 100 1

go run client/main.go "$1" 1048576 10 10 1 1
go run client/main.go "$1" 1048576 10 10 2 1
go run client/main.go "$1" 1048576 10 10 5 1
go run client/main.go "$1" 1048576 10 10 10 1
go run client/main.go "$1" 1048576 10 10 100 1

kill -9 $SERVER_PID
pkill main