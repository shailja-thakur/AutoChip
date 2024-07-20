module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire x, y;

assign x = c & d;
assign y = ~c & d;

assign mux_in[0] = 1;
assign mux_in[1] = x;
assign mux_in[2] = x | y;
assign mux_in[3] = x | y;

endmodule
