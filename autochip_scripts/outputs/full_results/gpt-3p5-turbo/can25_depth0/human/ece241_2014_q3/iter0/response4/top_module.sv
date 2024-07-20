module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

wire ab_00, ab_01, ab_11, ab_10;

// Generate the a'b' inputs for the mux
not (c, d, ab_00);
and (c, d, ab_01);
and (c, d, ab_11);
or (c, d, ab_10);

// Connect the outputs to the mux inputs
assign mux_in[0] = ab_00;
assign mux_in[1] = ab_01;
assign mux_in[2] = ab_11;
assign mux_in[3] = ab_10;

endmodule
