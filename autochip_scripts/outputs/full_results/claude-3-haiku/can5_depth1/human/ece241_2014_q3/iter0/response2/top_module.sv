module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    // Implement the Karnaugh map using 2-to-1 multiplexers
    wire d_bar = ~d;
    wire mux1_out, mux2_out, mux3_out;

    // mux_in[0] = c'd
    assign mux_in[0] = c & d_bar;

    // mux_in[1] = c'd
    assign mux_in[1] = c & d_bar;

    // mux_in[2] = c'd + cd
    assign mux2_out = c & d;
    assign mux3_out = c & d;
    assign mux_in[2] = mux2_out | mux3_out;

    // mux_in[3] = c'd + cd
    assign mux1_out = c & d_bar;
    assign mux_in[3] = mux1_out | mux3_out;

endmodule
