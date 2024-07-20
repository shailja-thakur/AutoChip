module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] intermediate;

assign mux_in[0] = 1'b1;
assign mux_in[1] = c;
assign mux_in[2] = d ^ c;
assign mux_in[3] = d;

assign intermediate[0] = c;
assign intermediate[1] = d;

endmodule
