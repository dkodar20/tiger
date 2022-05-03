# Summary of Entire Compilers project

## Reverse polish machine
- The entire code of reverse polish machine is present in the _reverse polish_ folder
- Support for divison and bracketing was added in the reverse polish compiler
- To test the working reverse polish machine use `make test` (inside the reverse polish folder)
- The compiler is able to perform basic arithmetic operations
- The tests can be found in _test.expr_ 
- The output after running `make test` is visible in the command line

## Tiger Compiler
- The entire code for the tiger compiler can be found in the _tiger_ folder in the root of the repository. Thus all the files and directories talked about below are contained in the tiger folder itself unless specifically specified
- The tiger compiler is made for compiling the `tiger` language
- The syntax for the tiger language can be viewed through the tests found in _tests/test.expr_ file. 
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
    - To run the compiler, use `make test` inside the tiger direcotry. This will generate the `mips` code corresponding to the test code in `tests/test.expr` file in `out.mips` file
    - To check to correctness of the mips code generated, use `make spim`, which will generate the output corresponding to the mips code in `out.mips` file in the terminal
    - You can also use `make spim` for directly executing both of the above steps together
    - Use `make clean` to clear the executables 
- Extras - 
    - The compiler features printing of basic blocks in order to know the control flow of the compiler and can be helpful in debugging. To print the basic blocks of MIPS assembly code corresponding to the the test case file, use `make basics`. The generated basic blocks are printed in both the terminal and are stored in the _basics.out_ file
- File Structure -  
    __Parsing__ - The code for parsing the files can be found in the _lexer_ folder inside the tiger directory. The lexer is responsible for making the AST corresponding to input file. The AST structure can be found in _lib/ast.sml_  
    __IR code generation__ - This is done using the _src/translate.sml_ file. The supporting files include _IR/ir.sml_ and _IR/temp.sml_ which contain the how the IR is represented
    __MIPS assemble program generation__ - This is a step by step process which first involves register allocation (done using _register-alloc/register-allocation.sml_) and then printing the MIPS assembly code (done using _src/machine.sml_). The supporting file includes _mips/mips.sml_ which is contains the MIPS structure  
    __Others__ - The code execution of the entire compiler is done from _src/ec.sml_. The code for basic blocks building can be found in _lib/basic-blocks.sml_. The `ML Basis`, which specifies specific file order can be found in _ec.mlb_ and _bb.mlb_ files  

## Tiger Compiler with Tree IR
- The entire code for the tiger compiler built based on Tree IR and canonization can be found in tiger_tree folder in the root of the repository.Thus all the files and directories talked about below are contained in the tiger folder itself unless specifically specified.
- All the features mentioned above can be found in the tiger tree compiler as well, except the `for` loop and printing in new lines
- Run `make test` and / or `make spim` inside the _tiger\_tree_ folder to test the code
- `make basics` can be run similarly inside the _tiger\_tree_ folder to print the basic blocks for the corresponding test code
- The tree based IR can be found in `IR/tree_ir.sml`. The translation to tree IR and canonization can be found in `src/translate_ir.sml` and `src/canonization.sml` respectively
- Other file structures and specifics remains similar to that of the tiger compiler without tree IR as specified before

## Other independent assignments
- The _lab-0_ folder contains the work required to be done in the preparation lab including a hello world sml program, which can by run through `Makefile`
- The _target/mips.sml_ file was created in order to capture the MIPS syntax in sml. This file is used in both the _tiger_ and _tiger\_tree_ compiler and can be found inside the mips folder of their directories as well
- The _graph.sml_ contains the representation of a generic graph in sml. These can be used in the compiler to represent its control flow graphs

## TODOs
- Add more functionalities to the tiger language like handling functions
- Make canonization for _tiger\_tree_  more generic
