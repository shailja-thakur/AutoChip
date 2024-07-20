module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

assign mux_in[0] = (~c & ~d);  // cd = 00
assign mux_in[1] = (~c & d);   // cd = 01
assign mux_in[2] = (c & ~d);   // cd = 11
assign mux_in[3] = (c & d);    // cd = 10

endmodule
