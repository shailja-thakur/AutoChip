module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire mux1_out, mux2_out;

    // First level of 2-to-1 multiplexers
    assign mux1_out = (c & d) | (~c & d);
    assign mux2_out = (c & ~d) | (~c & d);

    // Second level of 2-to-1 multiplexers
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = mux1_out;
    assign mux_in[2] = (mux1_out & mux2_out) | (mux2_out & ~c);
    assign mux_in[3] = (mux1_out & ~mux2_out) | (mux2_out & c);

endmodule
