module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] tmp;

assign tmp[0] = ~c;
assign tmp[1] = c;

assign mux_in[0] = tmp[0] & ~d;
assign mux_in[1] = tmp[0] & d;
assign mux_in[2] = tmp[1] & d;
assign mux_in[3] = tmp[1] & ~d;

endmodule
