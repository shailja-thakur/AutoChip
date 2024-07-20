module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire mux1_out, mux2_out;

    // First 2-to-1 multiplexer
    assign mux1_out = (c & d) | (~c & d);

    // Second 2-to-1 multiplexer
    assign mux2_out = (c & ~d) | (d);

    // 4-to-1 multiplexer
    assign mux_in[0] = 1;
    assign mux_in[1] = 0;
    assign mux_in[2] = mux2_out;
    assign mux_in[3] = mux1_out;

endmodule
