module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire mux2_out1, mux2_out2;

    // 2-to-1 multiplexers
    assign mux2_out1 = (c & d) | (~c & d);
    assign mux2_out2 = (c & ~d) | (~c & d);

    // 4-to-1 multiplexer
    assign mux_in[0] = 1'b1;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = mux2_out2;
    assign mux_in[3] = mux2_out1;

endmodule
