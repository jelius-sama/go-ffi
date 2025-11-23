package main

/*
 */
import "C"

//export Add
func Add(x, y C.int) C.int {
	return x + y
}

func main() {}
