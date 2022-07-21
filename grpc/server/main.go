package main

import (
	"context"
	benchmark "go.buf.build/grpc/go/loopholelabs/frisbee-benchmark"
	"google.golang.org/grpc"
	"log"
	"net"
	"os"
	"runtime"
	"time"
)

type svc struct {
	benchmark.UnimplementedBenchmarkServiceServer
}

func (s *svc) Benchmark(_ context.Context, req *benchmark.Request) (*benchmark.Response, error) {
	res := new(benchmark.Response)
	res.Message = req.Message
	return res, nil
}

func main() {
	lis, err := net.Listen("tcp", os.Args[1])
	if err != nil {
		panic(err)
	}

	shouldLog := len(os.Args) > 2

	grpcServer := grpc.NewServer()

	benchmark.RegisterBenchmarkServiceServer(grpcServer, new(svc))

	if shouldLog {
		go func() {
			err = grpcServer.Serve(lis)
			if err != nil {
				panic(err)
			}
		}()

		for {
			log.Printf("Num goroutines: %d\n", runtime.NumGoroutine())
			time.Sleep(time.Millisecond * 500)
		}
	} else {
		err = grpcServer.Serve(lis)
		if err != nil {
			panic(err)
		}
	}
}
