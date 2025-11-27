CC     := gcc
CFLAGS := -Wall -Wextra -static -O3 -s
CSLIBS := -L./libgolang -lgolang

GOC     := go
GOFLAGS := build -buildmode=c-archive -tags netgo -ldflags '-extldflags "-static"'

BIN     := bin/go-ffi
GOLIB   := libgolang/libgolang.a
GOSRC   := libgolang/golang.go
CSRC    := main.c

.PHONY: all clean

all: $(BIN)

$(GOLIB): $(GOSRC)
	@cd libgolang && $(GOC) $(GOFLAGS) -o libgolang.a golang.go 
	@echo Successfully build \`$(GOLIB)\`.

$(BIN): $(CSRC) $(GOLIB)
	@mkdir -p bin
	@$(CC) $(CFLAGS) -o $(BIN) $(CSRC) $(CSLIBS)
	@echo Successfully build \`$(BIN)\`.

clean:
	rm -f $(BIN) $(GOLIB)
