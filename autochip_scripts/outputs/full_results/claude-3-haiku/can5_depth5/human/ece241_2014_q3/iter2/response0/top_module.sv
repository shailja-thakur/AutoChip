module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire [1:0] cd = {c, d};

assign mux_in[0] = ~cd[1] & ~cd[0];
assign mux_in[1] = ~cd[1] &  cd[0];
assign mux_in[2] =  cd[1] &  cd[0];
assign mux_in[3] =  cd[1] ^ cd[0];

endmodule
