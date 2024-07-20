module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire mux1_out, mux2_out, mux3_out;

assign mux_in[0] = 1;
assign mux_in[1] = c;
assign mux_in[2] = c ^ d;
assign mux_in[3] = c | d;

endmodule
