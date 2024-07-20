module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	// Variable declaration
	reg [1023:0] input_vector;
	reg [3:0] start_index;
	
	// Assign input vector based on selection vector
	always @(*)
		input_vector = in;
		
	// Calculate start index based on selection vector
	always @(*)
		start_index = sel << 2;
		
	// Assign output vector based on input vector and start index
	always @(*)
		out = input_vector[start_index +: 4];
endmodule
