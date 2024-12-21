package main

import (
	"log"

	"github.com/simple-pdv/src/services"
)

func main() {
	server := services.CreateServer();

	log.Fatal(server.ListenAndServe());
}