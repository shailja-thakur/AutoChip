module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Intermediate signals for 2-to-1 multiplexers
	wire mux_1, mux_2, mux_3, mux_4, mux_5, mux_6;

	// Karnaugh map
	//       ab
	// cd   00 01 11 10
	//  00 | 0 | 0 | 0 | 1 |
	//  01 | 1 | 0 | 0 | 0 |
	//  11 | 1 | 0 | 1 | 1 |
	//  10 | 1 | 0 | 0 | 1 |

	// Implement logic for each mux_in output
	assign mux_in[0] = (c & d) | (!c & d) | (c & !d);
	assign mux_in[1] = 0;
	assign mux_in[2] = (c & d);
	assign mux_in[3] = d;

endmodule
