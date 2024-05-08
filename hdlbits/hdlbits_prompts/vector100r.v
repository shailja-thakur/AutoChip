// Given a 100-bit input vector [99:0], reverse its bit ordering

// Hint: A for loop (in a combinational always block or generate block) would be useful here. 
// I would prefer a combinational always block in this case because module 
// instantiations (which require generate blocks) aren't needed.

module top_module( 
    input [99:0] in,
    output [99:0] out
);
	// Insert your code here
endmodule
