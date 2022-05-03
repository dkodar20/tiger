# Summary of Entire Compilers project

## Reverse polish machine
- The entire code of reverse polish machine is present in the _`reverse-polish`_ folder
- Support for divison and bracketing was added in the reverse polish compiler
- To test the working reverse polish machine use `make test` (inside the reverse polish folder)
- The compiler is able to perform basic arithmetic operations
- The tests can be found in _`test.expr`_ 
- The output after running `make test` is visible in the command line

## Tiger Compiler
- The entire code for the tiger compiler can be found in the _`tiger`_ folder in the root of the repository. Thus all the files and directories talked about below are contained in the tiger folder itself unless specifically specified
- The tiger compiler is made for compiling the `tiger` language
- The syntax for the tiger language can be viewed through the tests found in _`tests/test.expr`_ file. 
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
    - The compiler features printing of basic blocks in order to know the control flow of the compiler and can be helpful in debugging. To print the basic blocks of MIPS assembly code corresponding to the the test case file, use `make basics`. The generated basic blocks are printed in both the terminal and are stored in the _`basics.out`_ file
- File Structure -  
    __Parsing__ - The code for parsing the files can be found in the _`lexer`_ folder inside the tiger directory. The lexer is responsible for making the AST corresponding to input file. The AST structure can be found in _`lib/ast.sml`_  
    __IR code generation__ - This is done using the _`src/translate.sml`_ file. The supporting files include _`IR/ir.sml`_ and _`IR/temp.sml`_ which contain the how the IR is represented
    __MIPS assemble program generation__ - This is a step by step process which first involves register allocation (done using _`register-alloc/register-allocation.sml`_) and then printing the MIPS assembly code (done using _`src/machine.sml`_). The supporting file includes _`mips/mips.sml`_ which is contains the MIPS structure  
    __Others__ - The code execution of the entire compiler is done from _`src/ec.sml`_. The code for basic blocks building can be found in _`lib/basic-blocks.sml`_. The `ML Basis`, which specifies specific file order can be found in _`ec.mlb`_ and _`bb.mlb`_ files  

## Tiger Compiler with Tree IR
- The entire code for the tiger compiler built based on Tree IR and canonization can be found in tiger_tree folder in the root of the repository.Thus all the files and directories talked about below are contained in the tiger folder itself unless specifically specified.
- All the features mentioned above can be found in the tiger tree compiler as well, except the `for` loop
- Run `make test` and / or `make spim` inside the _`tiger_tree`_ folder to test the code
- `make basics` can be run similarly inside the _`tiger_tree`_ folder to print the basic blocks for the corresponding test code
- The tree based IR can be found in _`IR/tree_ir.sml`_. The translation to tree IR and canonization can be found in _src/translate_ir.sml_ and _`src/canonization.sml`_ respectively
- Other file structures and specifics remains similar to that of the tiger compiler without tree IR as specified before

## Other independent assignments
- The _`lab-0`_ folder contains the work required to be done in the preparation lab including a hello world sml program, which can by run through `Makefile`
- The _`target/mips.sml`_ file was created in order to capture the MIPS syntax in sml. This file is used in both the _`tiger`_ and _`tiger_tree`_ compiler and can be found inside the mips folder of their directories as well
- The _`graph.sml`_ contains the representation of a generic graph in sml. These can be used in the compiler to represent its control flow graphs

## TODOs
- Add more functionalities to the tiger language like handling functions
- Make canonization for _`tiger_tree`_  more generic
