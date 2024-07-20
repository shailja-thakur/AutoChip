module top_module (
	input c,
	input d,
	output [3:0] mux_in
);

    // Declare internal wires for intermediate signals
    wire c_bar, d_bar;
    wire mux0_out, mux1_out, mux2_out, mux3_out;

    // Compute the complement of inputs c and d
    assign c_bar = ~c;
    assign d_bar = ~d;

    // Implement the logic using the required multiplexers
    assign mux_in[0] = ((c & d_bar) | (c_bar & d)) ? 1'b1 : 1'b0;
    assign mux_in[1] = (c & d_bar) ? 1'b1 : 1'b0;
    assign mux_in[2] = (c & d) ? 1'b1 : 1'b0;
    assign mux_in[3] = (c | d) ? 1'b1 : 1'b0;

endmodule
