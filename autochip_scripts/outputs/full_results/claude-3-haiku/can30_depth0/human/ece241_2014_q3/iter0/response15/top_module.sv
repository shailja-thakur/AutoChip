module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] temp;

assign temp[0] = (c & ~d) | (~c & d);
assign temp[1] = (c & d);

assign mux_in[0] = temp[0];
assign mux_in[1] = temp[0];
assign mux_in[2] = temp[1];
assign mux_in[3] = (c & ~d) | (~c & d) | (c & d);

endmodule
