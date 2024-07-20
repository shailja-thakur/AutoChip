module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // Wire Declarations
    wire w1 = ~a ^ a;
    wire w2 = ~a ^ b;
    wire w3 = ~a ^ c;
    wire w4 = ~a ^ d;
    wire w5 = ~a ^ e;
    wire w6 = ~b ^ a;
    wire w7 = ~b ^ b;
    wire w8 = ~b ^ c;
    wire w9 = ~b ^ d;
    wire w10 = ~b ^ e;
    wire w11 = ~c ^ a;
    wire w12 = ~c ^ b;
    wire w13 = ~c ^ c;
    wire w14 = ~c ^ d;
    wire w15 = ~c ^ e;
    wire w16 = ~d ^ a;
    wire w17 = ~d ^ b;
    wire w18 = ~d ^ c;
    wire w19 = ~d ^ d;
    wire w20 = ~d ^ e;
    wire w21 = ~e ^ a;
    wire w22 = ~e ^ b;
    wire w23 = ~e ^ c;
    wire w24 = ~e ^ d;
    wire w25 = ~e ^ e;

    // Output Assignments
    assign out[24] = w1;
    assign out[23] = w2;
    assign out[22] = w3;
    assign out[21] = w4;
    assign out[20] = w5;
    assign out[19] = w6;
    assign out[18] = w7;
    assign out[17] = w8;
    assign out[16] = w9;
    assign out[15] = w10;
    assign out[14] = w11;
    assign out[13] = w12;
    assign out[12] = w13;
    assign out[11] = w14;
    assign out[10] = w15;
    assign out[9] = w16;
    assign out[8] = w17;
    assign out[7] = w18;
    assign out[6] = w19;
    assign out[5] = w20;
    assign out[4] = w21;
    assign out[3] = w22;
    assign out[2] = w23;
    assign out[1] = w24;
    assign out[0] = w25;

endmodule
