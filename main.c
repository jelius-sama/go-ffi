#include <stdio.h>
#include "libgolang/libgolang.h"
#include <unistd.h>

int main() {
    char *msg;
    msg = Handler("/", "Hello, World!");
    printf("handler: %s", msg);

    msg = Handler("/kazu", "Hello, Kazuma!");
    printf("handler: %s", msg);

    msg = Handler("/coding", "ABSOLUTE CODING!!!");
    printf("handler: %s", msg);

    char *ret = StartServer(":6969");
    printf("net/http: %s", ret);

    for (;;) {
        pause();
    }

    return 0;
}
