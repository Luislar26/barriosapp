package main

import (
	//"database/sql"
	//"io/ioutil"
	"github.com/gin-gonic/gin"
	"github.com/gin-contrib/cors"
	"net/http"
)

//Traer el template "biblia.html" y llenarlo con los datos enviados
func index(c *gin.Context) {
	c.HTML(http.StatusOK, "index.html", gin.H{
		"title": "Principal",
	})
}

func main() {

	r := gin.Default() //Motor del Framework Gin

	//Activa los acceso, por ahora todos los origenes y metodos
	r.Use(cors.Default())

	//Rellena los template y Pone en public las carpetas
	r.LoadHTMLGlob("templates/*.html")
	r.Static("/public", "./public")

	//Funcion para servir los templates, estos estan fuera de public
	r.GET("/temp", func(c *gin.Context) {
		http.ServeFile(c.Writer, c.Request, "./templates/*")
	})

	r.GET("/", index)
	r.Run(":5000")
}
