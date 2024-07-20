module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] mux1_out;
    wire [1:0] mux2_out;

    // First level of 2-to-1 multiplexers
    assign mux1_out[0] = (c & d);
    assign mux1_out[1] = (c & ~d);

    assign mux2_out[0] = (c & d);
    assign mux2_out[1] = (~c & d);

    // Final 4-to-1 multiplexer
    assign mux_in[0] = mux1_out[0];
    assign mux_in[1] = mux1_out[1];
    assign mux_in[2] = (mux2_out[0] | mux2_out[1]);
    assign mux_in[3] = (c & d) | (~c & d);

endmodule
