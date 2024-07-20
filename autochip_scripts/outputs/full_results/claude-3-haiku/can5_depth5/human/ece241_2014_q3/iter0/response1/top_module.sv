module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire not_c = ~c;
wire not_d = ~d;
wire and1 = not_c & not_d;
wire and2 = c & not_d;
wire and3 = c & d;
wire and4 = not_c & d;

assign mux_in[0] = and1;
assign mux_in[1] = and2;
assign mux_in[2] = and3;
assign mux_in[3] = and4;

endmodule
