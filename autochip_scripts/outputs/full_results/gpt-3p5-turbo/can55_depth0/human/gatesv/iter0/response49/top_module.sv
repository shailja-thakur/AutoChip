module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);
	// Intermediate wire variables
	wire [3:0] shifted_in;

	// Connect shifted_in to the left shifted in vector
	assign shifted_in[0] = in[3];
	assign shifted_in[1] = in[0];
	assign shifted_in[2] = in[1];
	assign shifted_in[3] = in[2];

	// Calculate out_both
	assign out_both[0] = (in[0] && shifted_in[0]);
	assign out_both[1] = (in[1] && shifted_in[1]);
	assign out_both[2] = (in[2] && shifted_in[2]);

	// Calculate out_any
	assign out_any[1] = (in[1] || shifted_in[1]);
	assign out_any[2] = (in[2] || shifted_in[2]);
	assign out_any[3] = (in[3] || shifted_in[3]);

	// Calculate out_different
	assign out_different[0] = (in[0] != shifted_in[0]);
	assign out_different[1] = (in[1] != shifted_in[1]);
	assign out_different[2] = (in[2] != shifted_in[2]);
	assign out_different[3] = (in[3] != shifted_in[3]);
endmodule
