package login

type LoginDto struct {
	Nome  string `json:"nome" validate:"required,min=4,max=255"`
	Senha string `json:"senha" validate:"required,min=8"`
}

type LoginResponse struct {
	Id        string
	Criado_em string

	Nome  string
	Ativo bool
	Admin bool

	Senha_alterada_em string
	Access_token      string
}