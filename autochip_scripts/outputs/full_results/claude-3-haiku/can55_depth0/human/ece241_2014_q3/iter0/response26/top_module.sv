module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire m1, m2, m3;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign m1 = (c & ~d) | (~c & d);
assign m2 = (c & ~d) | (c & d);
assign m3 = (c & d);

// Connect the 2-to-1 multiplexer outputs to the 4-to-1 multiplexer inputs
assign mux_in[0] = 1'b1;
assign mux_in[1] = m1;
assign mux_in[2] = m2;
assign mux_in[3] = m3;

endmodule
