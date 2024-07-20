module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Mux inputs for each cell in the Karnaugh map
	wire cell_00 = ~c & ~d;
	wire cell_01 = c & ~d;
	wire cell_11 = c & d;
	wire cell_10 = ~c & d;

	// Connecting Karnaugh map cells to mux input pins
	assign mux_in[0] = cell_00;
	assign mux_in[1] = cell_01;
	assign mux_in[2] = cell_11;
	assign mux_in[3] = cell_10;

endmodule
