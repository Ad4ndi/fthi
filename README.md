# fthi v1.0 - A simple Forth interpreter

### Dependencies

- ocaml
- guile

### Install
```
$ git clone https://github.com/Ad4ndi/fthi
$ cd fthi
$ guile build.scm
```

### Usage

FTHI is a minimal implementation of the stack-based Forth programming language. Available functions:

- Arithmetic operations: `+`, `-`, `*`, `/`
- Logical operations: `<`, `>`, `=` (they return 0 (false) or 1 (true))
- Stack operations: `dup`, `swap`, `over`, `rot`, `drop`
- Memory operations: `@`, `!`, `,`
