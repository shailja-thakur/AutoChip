module top_module (
	input c,
	input d,
	output [3:0] mux_in
);
	
	/* Declare internal signals */
	wire [1:0] ab;
	
	/* Implementing the Karnaugh Map using multiplexers */
	assign ab[0] = (~c & ~d) | (c & d);
	assign ab[1] = (~c & d) | (c & ~d);
	
	/* Connecting the inputs to mux_in */
	assign {mux_in[3], mux_in[2], mux_in[1], mux_in[0]} = ab[1] ? {ab[0] & ab[1], ab[0], ab[0], ab[0]} : {ab[0] & ab[1], ab[0], ab[0], ab[0]};
	
endmodule
