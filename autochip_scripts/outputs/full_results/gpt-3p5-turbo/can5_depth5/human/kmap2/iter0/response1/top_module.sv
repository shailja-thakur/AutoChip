module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Implementing the logic function using four AND gates, three OR gates, and one NOT gate.

    wire w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13;
    
    assign w1 = a & b;
    assign w2 = !c & d;
    assign w3 = c & d;
    assign w4 = a & !b;
    assign w5 = w1 | w2;
    assign w6 = w3 | w4;
    assign w7 = w1 | w4;
    assign w8 = !w2 & w3;
    assign w9 = w7 & w8;
    assign w10 = w7 & !w8;
    assign w11 = !w7 & w8;
    assign w12 = a & b;
    assign w13 = c & d;
    
    assign out = !(w5 & w6) & (w9 | w10 | w11) & (w12 | w13);
    
endmodule
