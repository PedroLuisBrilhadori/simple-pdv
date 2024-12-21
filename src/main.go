package main

import (
	"fmt"

	"github.com/caarlos0/env/v11"
)

type config struct {
	Home string `env:"HOME"`
  }

func main() { 

	var cfg config
	cfg, err := env.ParseAs[config]()

	if err != nil {
		panic(err);
	}


	fmt.Printf("%s \n", cfg.Home);
}