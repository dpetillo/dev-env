package main

import (
	"fmt"
	"log"
	"os"

	"github.com/hashicorp/hcl2/hcl"
	"github.com/hashicorp/hcl2/hclwrite"
	//"github.com/hashicorp/hcl/v2/hclsimple"
)

type Config struct {
	Variable string `hcl:"test"`
}

func RemoveIndex(s []*hclwrite.Block, index int) []*hclwrite.Block {
	return append(s[:index], s[index+1:]...)
}

func hclToStruct(path string) {
	content, err := os.ReadFile(path)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(content))

	ast, diag := hclwrite.ParseConfig(content, "main.tf", hcl.InitialPos)

	f, err := os.OpenFile("main2.tf", os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0600)
	if err != nil {
		panic(err)
	}
	defer f.Close()

	//remove the second block
	b := RemoveIndex(ast.Body().Blocks(), 1)

	ast.Body().Clear()
	for i := 0; i < len(b); i++ {
		ast.Body().AppendBlock(b[i])
	}

	ast.WriteTo(f)
	log.Fatal(err)
	log.Print(ast)
	log.Print(diag)

}

func main() {
	hclToStruct("/home/derek/Dev/kube-dev-env/infra/main.tf")
}
