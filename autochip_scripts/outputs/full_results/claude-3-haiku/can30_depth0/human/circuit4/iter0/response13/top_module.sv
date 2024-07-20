module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire ac, bc, ad, bd;

assign ac = a & c;
assign bc = b & c;
assign ad = a & d;
assign bd = b & d;

assign q = (ac & ~bd) | (bc & ~ad) | (ac & bd) | (bc & ad);

endmodule
