module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire andcd, nandcd;

assign andcd = c & d;
assign nandcd = ~(c & d);

assign mux_in[0] = 1;
assign mux_in[1] = c;
assign mux_in[2] = nandcd;
assign mux_in[3] = andcd;

endmodule
