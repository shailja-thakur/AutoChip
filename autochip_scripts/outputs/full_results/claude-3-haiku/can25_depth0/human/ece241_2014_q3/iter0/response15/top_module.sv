module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire out1, out2, out3;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign out1 = (c & ~d) | (~c & d);
assign out2 = c & d;
assign out3 = (c & d) | (~c & d);

// Connect the outputs to the 4-to-1 multiplexer inputs
assign mux_in[0] = 1'b1;
assign mux_in[1] = out1;
assign mux_in[2] = out2;
assign mux_in[3] = out3;

endmodule
