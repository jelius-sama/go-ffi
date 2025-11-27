```c
void demo_fire_and_forget() {
    printf("\n=== DEMO: Fire-and-forget (void function) ===\n");

    // This would be a void function that doesn't return anything
    // TaskHandle task = TaskLaunchVoid(some_void_function, args);
    // Optional: TaskAwait(task, NULL) to wait for completion
}

void demo_non_blocking_poll() {
    printf("\n=== DEMO: Non-blocking poll pattern ===\n");
    printf("This is what we use in the main loop below\n");
    printf("Check task status without blocking, continue if not ready\n");
}

void demo_blocking_await() {
    printf("\n=== DEMO: Blocking await pattern ===\n");
    printf("TaskAwait(task, &result) - blocks until complete\n");
    printf("Useful for: initialization, cleanup, synchronization points\n");
}

void demo_timeout_await() {
    printf("\n=== DEMO: Timeout await pattern ===\n");
    printf("TaskAwaitTimeout(task, 5000, &result) - wait max 5 seconds\n");
    printf("Useful for: network operations, user input, resource acquisition\n");
}

// ============================================================================
// ARCHITECTURE NOTES
// ============================================================================
/*

KEY DESIGN DECISIONS:

1. UNIFIED TASK SYSTEM
   - TaskLaunch: For functions returning void*
   - TaskLaunchVoid: For functions returning nothing
   - Both use same handle type and waiting mechanisms

2. FLEXIBLE WAITING STRATEGIES
   - TaskPoll: Non-blocking check (event loops, polling)
   - TaskAwait: Blocking wait (synchronization points)
   - TaskAwaitTimeout: Blocking with deadline (network ops, user input)

3. CLEAR NAMING CONVENTION
   - Verb-first: TaskLaunch, ChannelCreate, HttpRegisterRoute
   - No abbreviations: "Launch" not "Go", "Await" not "Join"
   - Context prefix: Task*, Channel*, Http*

4. MEMORY OWNERSHIP
   - Heap allocation for cross-thread data
   - Caller responsible for freeing received channel data
   - TaskCleanup optional but recommended for long-running apps

5. RETURN VALUES
   - 0: Success/Complete
   - -1: In progress/Would block/Timeout
   - -2: Invalid handle/Closed
   - -3: Other errors

6. REAL-WORLD PATTERNS DEMONSTRATED
   - Event loop with non-blocking poll
   - Producer-consumer with channels
   - Async error handling
   - Resource cleanup

LESSONS LEARNED:
- Don't create redundant APIs (Go vs GoAsync)
- Support both blocking and non-blocking from the start
- Use descriptive names over brevity
- Make memory ownership explicit
- Provide both fire-and-forget and result-returning options
- Return codes should be consistent and documented

*/
```
