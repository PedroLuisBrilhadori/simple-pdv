package database

import (
	"database/sql"
	"fmt"

	"github.com/caarlos0/env/v11"
	_ "github.com/lib/pq"
)

type _DatabaseConfig struct {
	database    string `env:"DB_DATABASE"`
	db_port     string `env:"DB_PORT"`
	db_password string `env:"DB_PASSWORD"`
	db_user     string `env:"DB_USER"`
	db_host     string `env:"DB_HOST"`
}


func _GetDatabaseConfig() _DatabaseConfig {
	cfg, err := env.ParseAs[_DatabaseConfig]()

	if err != nil {
		panic("Erro,variáveis de ambientes para a conexão com o banco de dados não encontradas.")
	}

	return cfg;
}


func ConectDatabase() *sql.DB {
	cfg := _GetDatabaseConfig();
	connectString := fmt.Sprintf("user=%s dbname=%s password=%s host=%s port=%s", cfg.db_user, cfg.database, cfg.db_password, cfg.db_host, cfg.db_port);
	db, err := sql.Open("postgres", connectString); 

	if err != nil {
		panic(fmt.Sprintf("Erro, banco de dados não iniciado \n err: %s", err));
	}
	
	return db;
}