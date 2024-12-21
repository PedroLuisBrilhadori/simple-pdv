package services

import (
	"net/http"
	"time"

	"github.com/gorilla/mux"
	"github.com/simple-pdv/src/services/login"
)

func CreateServer() *http.Server {
    r := mux.NewRouter()


	r.NewRoute().Path("/login").Headers("Content-Type", "application/json",).HandlerFunc(login.Handler);

	server := &http.Server{
        Handler:      r,
        Addr:         "127.0.0.1:8000",
        // Good practice: enforce timeouts for servers you create!
        WriteTimeout: 15 * time.Second,
        ReadTimeout:  15 * time.Second,
    }

	r.Headers()

	return server;
}

