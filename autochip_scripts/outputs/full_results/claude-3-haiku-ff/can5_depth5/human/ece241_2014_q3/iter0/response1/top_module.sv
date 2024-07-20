module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire mux1_out, mux2_out, mux3_out;

// 2-to-1 mux for mux_in[0]
assign mux_in[0] = (c & d);

// 2-to-1 mux for mux_in[1]
assign mux1_out = (c & ~d);
assign mux_in[1] = mux1_out;

// 2-to-1 mux for mux_in[2]
assign mux2_out = (c & d);
assign mux3_out = (c & ~d);
assign mux_in[2] = (a & mux2_out) | (~a & mux3_out);

// 2-to-1 mux for mux_in[3]
assign mux_in[3] = (c & d) | (~c & d);

endmodule
