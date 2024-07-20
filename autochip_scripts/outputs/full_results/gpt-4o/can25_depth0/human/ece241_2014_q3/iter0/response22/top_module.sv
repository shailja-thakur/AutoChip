module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Based on the given K-map, we can determine the values of mux_in[3:0] depending on inputs c and d.
	// mux_in[0]: When ab = 00
	assign mux_in[0] = (~c & ~d); // Output 1 when c = 0, d = 1, 10, 11  (maps to 1 for c=0,d=0; 1 for c=1,d=0; and so on)

	// mux_in[1]: When ab = 01
	assign mux_in[1] = 1'b0; // Output is always 0

	// mux_in[2]: When ab = 11
	assign mux_in[2] = (c & d); // Output 1 when c = 1, d = 0, 1, 10, 11 (maps to 1 for c=1,d=1 and c=0,d=1; both cases are 10 and 11)

	// mux_in[3]: When ab = 10
	assign mux_in[3] = (c & ~d) | (~c & d); // Output 1 when c = 0, d = 1, 1, 1 (maps to 1 for c=1,d=0; both cases to 1 for c=1,d=1, 10, and 11 coming in.)

endmodule
