module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

	// Assigning out_both to the result of a bitwise AND operation between the input (in) vector bits 2 through 0 and the input (in) vector bits 3 through 1
	assign out_both = in[2:0] & in[3:1];
	
	// Assigning out_any to the result of a bitwise OR operation between the input (in) vector bits 2 through 0 and the input (in) vector bits 3 through 1
	assign out_any = in[2:0] | in[3:1];
	
	// Assigning out_different to the result of a bitwise XOR operation between the input (in) vector and the input (in) vector bits 3 through 1 with the input (in) vector bit 0 as an exception
	assign out_different = {in[3] ^ in[2:0], in[1:0] ^ 1'b0};

endmodule
