module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

xor x1(out[0], ~a, a);
xor x2(out[1], ~a, a);
xor x3(out[2], ~a, a);
xor x4(out[3], ~a, a);
xor x5(out[4], ~a, a);

xor x6(out[5], ~b, b);
xor x7(out[6], ~b, b);
xor x8(out[7], ~b, b);
xor x9(out[8], ~b, b);
xor x10(out[9], ~b, b);

xor x11(out[10], ~c, c);
xor x12(out[11], ~c, c);
xor x13(out[12], ~c, c);
xor x14(out[13], ~c, c);
xor x15(out[14], ~c, c);

xor x16(out[15], ~d, d);
xor x17(out[16], ~d, d);
xor x18(out[17], ~d, d);
xor x19(out[18], ~d, d);
xor x20(out[19], ~d, d);

xor x21(out[20], ~e, e);
xor x22(out[21], ~e, e);
xor x23(out[22], ~e, e);
xor x24(out[23], ~e, e);
xor x25(out[24], ~e, e);

endmodule
