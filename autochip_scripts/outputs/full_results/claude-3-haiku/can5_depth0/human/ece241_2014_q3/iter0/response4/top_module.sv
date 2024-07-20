module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire cd_0, cd_1, cd_2, cd_3;

// Implement the Karnaugh map using 2-to-1 multiplexers
assign cd_0 = c ? 0 : 1;
assign cd_1 = c ? 1 : 0;
assign cd_2 = (c & d) | (~c & d);
assign cd_3 = (c & d) | (c & ~d);

// Connect the intermediate results to the 4-to-1 multiplexer
assign mux_in[0] = cd_0;
assign mux_in[1] = cd_1;
assign mux_in[2] = cd_2;
assign mux_in[3] = cd_3;

endmodule
