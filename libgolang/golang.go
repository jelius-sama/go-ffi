package main

/*
#include <stdint.h>

typedef void (*cfunc_t)(void*);

static inline void callFunc(cfunc_t fn, void* arg) {
    fn(arg);
}
*/
import "C"

import (
	"fmt"
	"net/http"
	"unsafe"
)

var (
	Router = http.NewServeMux()
)

//export Go
func Go(fn unsafe.Pointer, arg unsafe.Pointer) {
	go func() {
		C.callFunc((C.cfunc_t)(fn), arg)
	}()
}

//export Handler
func Handler(route, bytes *C.char) *C.char {
	Router.HandleFunc(C.GoString(route), (func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte(C.GoString(bytes)))
	}))

	return C.CString("Registered route `" + C.GoString(route) + "`\n")
}

//export StartServer
func StartServer(port *C.char) *C.char {
	fmt.Println("Server started on port " + C.GoString(port))

	if err := http.ListenAndServe(C.GoString(port), Router); err != nil {
		return C.CString(err.Error() + "\n")
	}

	return C.CString("unreachable\n")
}

func main() {}
