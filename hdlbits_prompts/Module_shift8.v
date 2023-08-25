// You are given a module my_dff8 with two inputs and one output (that implements a set of 8 D flip-flops). 
// Instantiate three of them, then chain them together to make a 8-bit wide shift register of length 3. 
// In addition, create a 4-to-1 multiplexer (not provided) that chooses what to output depending on sel[1:0]: 
// The value at the input d, after the first, after the second, or after the third D flip-flop. 
// (Essentially, sel selects how many cycles to delay the input, from zero to three clock cycles.)

// The module provided to you is: 

module my_dff8 ( input clk, input [7:0] d, output [7:0] q );

// Hint: The multiplexer is not provided. One possible way to write one is inside an always block with a case statement inside.

module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
	// Insert your code here
endmodule

