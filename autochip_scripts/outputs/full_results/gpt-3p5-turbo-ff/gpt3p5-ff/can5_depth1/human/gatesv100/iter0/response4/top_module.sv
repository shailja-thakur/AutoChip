module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);
	// The output vector out_both will contain 99 bits
	// Each bit in out_both will indicate whether the corresponding input bit and its neighbor to the left are both '1'
	// We can use a simple bitwise AND operation to accomplish this

	// Declare a temporary wire variable to store the result of the bitwise AND operation
	wire [98:0] both_temp;
	
	// Perform the bitwise AND operation for each bit in the input vector
	assign both_temp = in[98:0] & in[99:1];
	
	// Assign the result to the output vector
	assign out_both = both_temp;

	// The output vector out_any will contain 99 bits
	// Each bit in out_any will indicate whether the corresponding input bit or its neighbor to the right is '1'
	// We can use a simple bitwise OR operation to accomplish this

	// Declare a temporary wire variable to store the result of the bitwise OR operation
	wire [99:1] any_temp;
	
	// Perform the bitwise OR operation for each bit in the input vector
	assign any_temp = in[0:98] | in[1:99];
	
	// Assign the result to the output vector
	assign out_any = any_temp;

	// The output vector out_different will contain 100 bits
	// Each bit in out_different will indicate whether the corresponding input bit is different from its neighbor to the left
	// We can use a simple inequality comparison to accomplish this

	// Declare a temporary wire variable to store the result of the inequality comparison
	wire [99:0] different_temp;
	
	// Perform the inequality comparison for each bit in the input vector
	// For the last bit, compare it with the first bit by wrapping around the vector
	assign different_temp = (in[98:0] != in[99]) ? 1 : 0;
	
	// Assign the result to the output vector
	assign out_different = different_temp;
	
endmodule
