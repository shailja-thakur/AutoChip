module top_module(
    input c,
    input d,
    output [3:0] mux_in
);

wire w1, w2, w3;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign w1 = c ? 1'b0 : 1'b1;
assign w2 = c ? 1'b0 : (d ? 1'b1 : 1'b0);
assign w3 = c ? (d ? 1'b1 : 1'b0) : 1'b1;

// Connect the outputs to the 4-to-1 multiplexer
assign mux_in[0] = w1;
assign mux_in[1] = w2;
assign mux_in[2] = w3;
assign mux_in[3] = c ? (d ? 1'b1 : 1'b0) : 1'b1;

endmodule
