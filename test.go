package main

import (
  "fmt"
  "bufio"
  "os"
)

func main() {
  fmt.Println("hello world")
  test()  
  thing()

  fmt.Println("autochdir")
}

func test() {
  reader := bufio.NewReader(os.Stdin)
  text, _ := reader.ReadString('\n')
  fmt.Println(text)
}

func thing() {
  fmt.Println("Perfect")
}

