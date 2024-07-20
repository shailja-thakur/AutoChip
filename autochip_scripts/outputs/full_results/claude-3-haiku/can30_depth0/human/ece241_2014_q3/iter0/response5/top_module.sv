module top_module (
    input c, 
    input d,
    output [3:0] mux_in
);

wire mux_0, mux_1;

// Implement the Karnaugh map using 2:1 multiplexers
assign mux_0 = (c & d) | (~c & d);
assign mux_1 = (c & ~d) | (c & d);

// Connect the 2:1 multiplexer outputs to the 4:1 multiplexer inputs
assign mux_in[0] = 1'b1;
assign mux_in[1] = mux_0;
assign mux_in[2] = mux_1;
assign mux_in[3] = (c & d) | (~c & d) | (c & ~d);

endmodule
