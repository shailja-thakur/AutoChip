module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire mux2_out1, mux2_out2;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign mux_in[0] = 1;
assign mux_in[1] = c;
assign mux2_out1 = d;
assign mux2_out2 = c;
assign mux_in[2] = (c & d) | (~c & d);
assign mux_in[3] = (c & d) | (c & ~d);

endmodule
