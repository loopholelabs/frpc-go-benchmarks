/*
	Copyright 2022 Loophole Labs

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		   http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/
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
