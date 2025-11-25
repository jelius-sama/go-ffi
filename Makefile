CC := gcc
CFLAGS := -Wall -Wextra -O3
CSLIBS := -L./libgolang -lgolang

GOC := go
GOFLAGS := build -buildmode=c-archive

.PHONY: build clean

build:
	@cd libgolang && $(GOC) $(GOFLAGS) -o ./libgolang.a ./golang.go
	@mkdir -p ./bin
	@$(CC) $(CFLAGS) -o ./bin/go-ffi ./main.c $(CSLIBS)
	@echo "Successfully built \`./bin/go-ffi\`."

clean:
	rm ./bin/go-ffi
	rm ./libgolang/libgolang.a
