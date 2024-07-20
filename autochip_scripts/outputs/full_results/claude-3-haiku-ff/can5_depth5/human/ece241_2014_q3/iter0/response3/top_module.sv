module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire cd0, cd1, cd2, cd3;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign cd0 = (~c & ~d) | (c & d);
assign cd1 = ~c & d;
assign cd2 = (c & ~d) | (c & d);
assign cd3 = (c & ~d) | (~c & d) | (c & d);

// Connect the outputs of the 2-to-1 multiplexers to the 4-to-1 multiplexer inputs
assign mux_in[0] = cd0;
assign mux_in[1] = cd1;
assign mux_in[2] = cd2;
assign mux_in[3] = cd3;

endmodule
