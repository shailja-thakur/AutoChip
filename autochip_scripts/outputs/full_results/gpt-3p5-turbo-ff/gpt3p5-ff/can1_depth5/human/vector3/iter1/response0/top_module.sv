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
	
	wire [4:0] input_concatenated;
	assign input_concatenated = {f, e, d, c, b, a}; 
	
	wire [9:0] output_concatenated;
	assign output_concatenated = {input_concatenated, 2'b11};
	
	assign w = output_concatenated[7:0];
	assign x = output_concatenated[6:0]; // Fixing the part select range
	assign y = output_concatenated[5:0]; // Fixing the part select range
	assign z = output_concatenated[4:0]; // Fixing the part select range
	
endmodule
