module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire not_c, not_d;
wire and1, and2, and3, and4;

// Implement the Karnaugh map using multiplexers
assign not_c = ~c;
assign not_d = ~d;

assign and1 = not_c & not_d;
assign and2 = not_c & d;
assign and3 = c & d;
assign and4 = c & not_d;

assign mux_in[0] = and1;
assign mux_in[1] = and2;
assign mux_in[2] = and3;
assign mux_in[3] = and4;

endmodule
