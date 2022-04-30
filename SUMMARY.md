# Summary of Entire Compilers project

## Lab - 0

## Reverse polish machine
- The entire code of reverse polish machine is present in the _reverse polish_ folder. 
- Support for divison and bracketing was added in the reverse polish compiler
- To test the working reverse polish machine use `make test` (inside the reverse polish folder)
- The compiler is able to perform basic arithmetic operations
- The tests can be found in _test.expr_ 
- The output after running `make test` is visible in the command line

## Tiger Compiler
- The entire code for the tiger compiler can be found in the _tiger_ folder
- The tiger compiler is made for compiling the `tiger` language. 
- The syntax for the tiger language can be found in _test.expr_ file. 
- The tiger language supports the following features -
    - Variable assignments
    - Variable manipulation using aithmetic operations including addition, multiplication and subtraction
    - Parantheses support
    - Variables can be assigned and updated using parenthesized expressions involving other vairables and constants
    - Supports `for` loops. Features in `for` loop -
        - Local declaration of statements
        - When a variable declared outside the for loop is reassigned a value inside the for loop then after the for loop ends, the older value is stored back in the variable again
        - The variable used as an iterator for the loop is also trated as a local variable
    - Printing of expressions is supported using `print <expr>` command where the expression is first evaluated and then printed. Each print statement is executed in a new line (like _python_)!
- Running the compiler -
    - To run the compiler, use `make test` inside the tiger direcotry. This will generate the `mips` code corresponding to the test code in `tests/test.expr` file in `out.mips` file.
    - To check to correctness of the mips code generated, use `make spim`, which will generate the output corresponding to the mips code in `out.mips` file in the terminal.
    - You can also use `make spim` for directly executing both of the above steps together.

