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

	// Concatenate input vectors
	reg [4:0] concat_input [0:5];
	always @* begin
		concat_input[0] = a;
		concat_input[1] = b;
		concat_input[2] = c;
		concat_input[3] = d;
		concat_input[4] = e;
		concat_input[5] = f;
	end
	
	// Output vectors
	reg [31:0] concat_output;
	reg [7:0] split_output [0:3];
	
	// Concatenate input vectors and two 1 bits
	always @* begin
		concat_output = {concat_input[5], concat_input[4], concat_input[3], concat_input[2], concat_input[1], concat_input[0], 2'b11};
	end
	
	// Split concatenated output into separate vectors
	always @* begin
		split_output[0] = concat_output[31:24];
		split_output[1] = concat_output[23:16];
		split_output[2] = concat_output[15:8];
		split_output[3] = concat_output[7:0];
	end
	
	// Assign output vectors
	assign {w, x, y, z} = {split_output[0], split_output[1], split_output[2], split_output[3]};
	
endmodule
