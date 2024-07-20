module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire and1, and2, and3;

assign mux_in[0] = 1'b1;
assign mux_in[1] = c;
assign and1 = c & d;
assign and2 = ~c & d;
assign and3 = c & ~d;
assign mux_in[2] = and1 | and3;
assign mux_in[3] = and2 | and3;

endmodule
