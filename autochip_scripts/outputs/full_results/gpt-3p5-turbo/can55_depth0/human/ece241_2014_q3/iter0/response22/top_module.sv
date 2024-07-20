module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Intermediate wires to connect outputs of 2-to-1 MUXes
wire mux_out0, mux_out1, mux_out2, mux_out3;

// Implementing 2-to-1 MUXes for each of the 4 inputs of 4-to-1 MUX
module mux_2to1 (
	input a,
	input b,
	input sel,
	output out
);

// 2-to-1 MUX implementation
	assign mux_out0 = (c & !d) | (!c & d);
	assign mux_out1 = (!c & !d);
	assign mux_out2 = (!c & d);
	assign mux_out3 = (c & !d) | (!c & d);

	// Connecting outputs of 2-to-1 MUXes to the inputs of 4-to-1 MUX
	assign mux_in[0] = mux_out0;
	assign mux_in[1] = mux_out1;
	assign mux_in[2] = mux_out2;
	assign mux_in[3] = mux_out3;

endmodule
module mux_2to1 (
	input a,
	input b,
	input sel,
	output out
);

	// 2-to-1 MUX implementation
	assign out = (a & !sel) | (b & sel);

endmodule
