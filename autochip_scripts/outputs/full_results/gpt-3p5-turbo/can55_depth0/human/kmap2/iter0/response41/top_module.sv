module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12;

and gate1(w1, a, b);
or gate2(w2, !a, !b, !c);
and gate3(w3, !a, b);
and gate4(w4, a, !b);
and gate5(w5, !c, d);
and gate6(w6, !c, !d);
and gate7(w7, c, d);
and gate8(w8, c, !d);
or gate9(w9, w1, w2, w3);
or gate10(w10, w4, w5, w6);
or gate11(w11, w2, w7, w8);
or gate12(w12, w11, w10);

assign out = w9 & w12;

endmodule
