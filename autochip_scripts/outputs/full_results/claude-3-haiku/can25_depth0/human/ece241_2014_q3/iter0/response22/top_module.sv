module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire a, b;
wire [1:0] cd;

assign cd = {c, d};
assign a = (~cd[1] & ~cd[0]) | (cd[1] & cd[0]);
assign b = (~cd[1] & cd[0]) | (cd[1] & ~cd[0]);

assign mux_in[0] = 1;
assign mux_in[1] = 1;
assign mux_in[2] = (a & b) | (~a & b);
assign mux_in[3] = (a & ~b) | (a & b);

endmodule
