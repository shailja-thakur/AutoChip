module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

	// Assign the first bit to the logical OR of c and d
	assign mux_in[0] = c | d;
	
	// Assign the second bit to 0
	assign mux_in[1] = 1'b0;
	
	// Assign the third bit to the logical NOT of d
	assign mux_in[2] = ~d;
	
	// Assign the fourth bit to the logical AND of c and d
	assign mux_in[3] = c & d;

endmodule
