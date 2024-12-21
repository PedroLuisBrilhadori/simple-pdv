package login

import (
	"encoding/json"
	"io"
	"net/http"

	"github.com/go-playground/validator/v10"
)

func Handler(w http.ResponseWriter, r *http.Request) {
	var dto LoginDto; 
	body, jsonErr := io.ReadAll(r.Body);

	if jsonErr != nil {
		json.NewEncoder(w).Encode("{sucess: false}");
		return;
	}

	if json.Unmarshal(body, &dto) != nil {
		json.NewEncoder(w).Encode("{sucess: asdf}");
		return;
	}
	
	validate := validator.New()

	err := validate.Struct(dto);

	if err != nil {
		validationErrors := err.(validator.ValidationErrors)
		json.NewEncoder(w).Encode(validationErrors.Error());
		return;
	}

	json.NewEncoder(w).Encode("{sucess: true}");
}