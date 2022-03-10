## Feb - 17
I forgot to update changelog till now. Adding all the things done till now from here.
- Made a makefile to run a hello world program in sml in lab - 0
- Added division and bracketing in reverse polish compiler in lab - 1

In lab 2 -
- Created a MIPS structure in target/mips.sml file
- Added various datatypes corresponding to MIPS like register, instruction, directive
- Made functions to print instructions and statements according to MIPS documentation corresponding to various datatype constructors.  

# Structure after this
- The tiger folder contains the compiler
- Use `make test` to test the compiler against tests which are stored in test/test.expr
- The output of tests is generated in output.mips
- MIPS structure is contained in the mips folder and the lex and grm files are in the lexer forlder
- Use `make spim` to run the output.mips through spim to check the working of code

## Mar 3
Forgot to update this again :(

In lab 3 -
- Tiger compiler was made to handle a simple language called "Tiger" which converts it into MIPS
- The output is generated in out.mips file and can be run using `make spim` command
- Operations handled now are add, subtract, multiply and print
 
## Mar 10

In lab 4 - 
- For loop support is added to the tiger language
- Syntax of for loop can be found in the test file

