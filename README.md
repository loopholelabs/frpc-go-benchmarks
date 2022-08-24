# fRPC-Go Benchmarks

This repository contains a series of benchmarks for the Go implementation of fRPC. You can learn more about these benchmarks at [https://frpc.io/performance](https://frpc.io/performance).

## fRPC Benchmark

This benchmark is designed to be a 1:1 comparison with gRPC and other RPC frameworks for sending and receiving large numbers of messages.
In order to facilitate this, all the RPC implementations make use of the same `benchmark.proto` file, and the server and client code
was generated using version `libprotoc 3.19.4`.

We've also kept the client and server implementations the exact same (with only the instantiation of the servers and clients being different).

### gRPC

To start the gRPC benchmark, you must start the server and then the client (in that order). You can start them like so:

```shell
go run server/main.go localhost:8192
go run client/main.go localhost:8192 <bytes per message> <number of messages> <repetitions> <number of clients> <number of parallel senders per client>
```

### fRPC Side

To start the fRPC benchmark, you must start the server and then the client (in that order). You can start them like so:

```shell
go run server/main.go localhost:8192
go run client/main.go localhost:8192 <bytes per message> <number of messages> <repetitions> <number of clients> <number of parallel senders per client>
```
