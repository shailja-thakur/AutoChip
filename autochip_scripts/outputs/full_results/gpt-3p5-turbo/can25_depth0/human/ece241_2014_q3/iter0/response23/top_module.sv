module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

// Declare internal signals
wire ab_00, ab_01, ab_11, ab_10;

// Create logic for selecting mux_in values based on c and d inputs
assign ab_00 = (c & ~d);
assign ab_01 = (~c & ~d);
assign ab_11 = (~c & d) | (c & d);
assign ab_10 = (c & ~d) | (c & d);

// Connect mux_in to the 4-to-1 multiplexer based on ab values
assign mux_in[0] = ab_00;
assign mux_in[1] = ab_01;
assign mux_in[2] = ab_11;
assign mux_in[3] = ab_10;

endmodule
