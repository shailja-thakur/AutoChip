module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire x, y, z;

assign x = c | d;
assign y = ~c & d;
assign z = c & d;

assign mux_in[0] = 1;
assign mux_in[1] = x;
assign mux_in[2] = y | z;
assign mux_in[3] = x | z;

endmodule
