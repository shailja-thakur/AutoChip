module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire mux1_out, mux2_out, mux3_out;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign mux1_out = (c & d) | (~c & d);
assign mux2_out = (c & ~d) | (~c & ~d);
assign mux3_out = (c & d) | (c & ~d) | (~c & d);

// Connect the 2-to-1 mux outputs to the 4-to-1 mux inputs
assign mux_in[0] = mux1_out;
assign mux_in[1] = mux2_out;
assign mux_in[2] = mux3_out;
assign mux_in[3] = (c & d) | (~c & d) | (c & ~d);

endmodule
