module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Internal wires
	wire [2:0] temp_both;
	wire [3:1] temp_any;
	wire [3:0] temp_different;

	// Combinational logic for out_both
	assign temp_both[0] = in[0] & in[3];
	assign temp_both[1] = in[1] & in[0];
	assign temp_both[2] = in[2] & in[1];

	// Combinational logic for out_any
	assign temp_any[0] = in[1] | in[0];
	assign temp_any[1] = in[2] | in[1];
	assign temp_any[2] = in[3] | in[2];
	assign temp_any[3] = in[0] | in[3];

	// Combinational logic for out_different
	assign temp_different[0] = in[3] ^ in[0];
	assign temp_different[1] = in[0] ^ in[1];
	assign temp_different[2] = in[1] ^ in[2];
	assign temp_different[3] = in[2] ^ in[3];

	// Output assignment
	assign out_both = temp_both;
	assign out_any = temp_any;
	assign out_different = temp_different;

endmodule
