package main

import (
	"context"
	"github.com/loopholelabs/frpc-go-benchmarks/frpc/benchmark"
	"github.com/rs/zerolog"
	"log"
	"os"
	"runtime"
	"time"
)

type svc struct{}

func (s *svc) Benchmark(_ context.Context, req *benchmark.Request) (*benchmark.Response, error) {
	res := new(benchmark.Response)
	res.Message = req.Message
	return res, nil
}

func main() {
	shouldLog := len(os.Args) > 2
	var logger *zerolog.Logger
	if shouldLog {
		l := zerolog.New(os.Stdout).Level(zerolog.InfoLevel)
		logger = &l
	}
	frisbeeServer, err := benchmark.NewServer(new(svc), nil, logger)
	if err != nil {
		panic(err)
	}

	if shouldLog {
		go func() {
			err = frisbeeServer.Start(os.Args[1])
			if err != nil {
				panic(err)
			}
		}()

		for {
			log.Printf("Num goroutines: %d\n", runtime.NumGoroutine())
			time.Sleep(time.Millisecond * 500)
		}
	} else {
		err = frisbeeServer.Start(os.Args[1])
		if err != nil {
			panic(err)
		}
	}
}
