module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Assign values to mux_in[0] to mux_in[3] based on the K-map
	
	// K-map:
	//      ab
	// cd   00 01 11 10
	// 00  | 0 | 0 | 0 | 1 |
	// 01  | 1 | 0 | 0 | 0 |
	// 11  | 1 | 0 | 1 | 1 |
	// 10  | 1 | 0 | 0 | 1 |
	
	// Assigning values based on the K-map cells:
	assign mux_in[0] = (!c && !d) ? 0 :   // 00
	                   (c && !d) ? 1 :    // 10
	                   (c && d) ? 1 : 0;  // 11
	assign mux_in[1] = 0;                 // 01 (always 0)
	assign mux_in[2] = (!c && d) ? 0 :    // 01
	                   (c && d) ? 1 : 0;  // 11
	assign mux_in[3] = (!c && !d) ? 1 :   // 00
	                   (!c && d) ? 0 :    // 10
	                   (c && d) ? 1 : 0;  // 11

endmodule
