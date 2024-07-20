module top_module (
	input [4:0] a,
	input [4:0] b,
	input [4:0] c,
	input [4:0] d,
	input [4:0] e,
	input [4:0] f,
	output [7:0] w,
	output [7:0] x,
	output [7:0] y,
	output [7:0] z
);
	
	// Concatenate the input vectors
	// Concat the input vectors to form a 30-bit vector
	reg [29:0] input_concatenated;
	always @(*) begin
		input_concatenated = {a, b, c, d, e, f};
	end
	
	// Add two 1 bits in the LSB positions
	// Add two 1 bits to the input concatenated vector to obtain a 32-bit vector
	reg [31:0] output_concatenated;
	always @(*) begin
		output_concatenated = {input_concatenated, 2'b11};
	end
	
	// Split the output vector
	// Split the output concatenated vector into four 8-bit vectors
	assign w = output_concatenated[31:24];
	assign x = output_concatenated[23:16];
	assign y = output_concatenated[15:8];
	assign z = output_concatenated[7:0];
	
endmodule
