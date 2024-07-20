module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire mux1_out, mux2_out, mux3_out;

// 2-to-1 multiplexer for mux_in[0]
assign mux_in[0] = c;

// 2-to-1 multiplexer for mux_in[1]
assign mux_in[1] = d;

// 2-to-1 multiplexer for mux_in[2]
assign mux2_out = d;
assign mux_in[2] = (c) ? mux2_out : 1'b1;

// 2-to-1 multiplexer for mux_in[3]
assign mux3_out = (c) ? 1'b1 : d;
assign mux_in[3] = (d) ? mux3_out : 1'b1;

endmodule
