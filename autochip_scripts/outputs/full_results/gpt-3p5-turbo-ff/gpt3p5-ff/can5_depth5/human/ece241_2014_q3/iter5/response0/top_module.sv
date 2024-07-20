module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire a, b;

assign a = !c & !d;
assign b = c & d;

assign mux_in[0] = !b;
assign mux_in[1] = b;
assign mux_in[2] = a;
assign mux_in[3] = !a;

endmodule
