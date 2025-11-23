.PHONY: dynamic-link static-link

dynamic:
	go build -buildmode=c-shared -o ./add/libadd.so ./add/add.go
	gcc -Wall -Wextra -O3 \
		-o ./dynamic ./main.c \
		-L./add -ladd \
		-Wl,-rpath,'$$ORIGIN/add'

static:
	go build -buildmode=c-archive -o ./add/libadd.a ./add/add.go
	gcc -Wall -Wextra -static -O3 \
		-o ./static ./main.c ./add/libadd.a \
		-pthread -ldl
