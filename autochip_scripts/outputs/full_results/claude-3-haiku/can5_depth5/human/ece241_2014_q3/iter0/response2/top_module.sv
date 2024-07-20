module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

    wire [1:0] mux1_out, mux2_out;

    // Implement the Karnaugh map using two 2-to-1 multiplexers
    assign mux1_out[0] = 1'b1;
    assign mux1_out[1] = 1'b0;
    assign mux1_out[0] = c ? mux1_out[1] : mux1_out[0];

    assign mux2_out[0] = 1'b0;
    assign mux2_out[1] = 1'b1;
    assign mux2_out[0] = d ? mux2_out[1] : mux2_out[0];

    // Connect the outputs of the 2-to-1 multiplexers to the 4-to-1 multiplexer
    assign mux_in[0] = mux1_out[0];
    assign mux_in[1] = mux1_out[1];
    assign mux_in[2] = mux2_out[1];
    assign mux_in[3] = mux2_out[0];

endmodule
