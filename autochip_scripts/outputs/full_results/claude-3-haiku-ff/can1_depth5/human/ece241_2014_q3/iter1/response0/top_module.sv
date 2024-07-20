module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] mux1_out, mux2_out;

    // 2-to-1 mux1
    assign mux1_out[0] = d;
    assign mux1_out[1] = 1'b0;

    // 2-to-1 mux2
    assign mux2_out[0] = ~c;
    assign mux2_out[1] = c;

    // 4-to-1 mux
    assign mux_in[0] = mux1_out[0];
    assign mux_in[1] = mux1_out[1];
    assign mux_in[2] = mux2_out[1];
    assign mux_in[3] = mux2_out[0];
endmodule
