module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
	// Internal wires
	wire [8:0] a_ext;
	wire [8:0] b_ext;
	wire [8:0] s_ext;
	wire overflow;

	// Sign extension
	assign a_ext = {{1{a[7]}}, a};
	assign b_ext = {{1{b[7]}}, b};

	// Addition
	assign s_ext = a_ext + b_ext;

	// Slices of the result
	assign s = s_ext[7:0];
	assign overflow = (s_ext[8] != s_ext[7]);

endmodule
