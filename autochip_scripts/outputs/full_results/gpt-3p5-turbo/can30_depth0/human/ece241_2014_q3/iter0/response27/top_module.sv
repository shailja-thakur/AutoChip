module top_module (
    input c,
    input d,
    output [3:0] mux_in
);

wire w1, w2, w3, w4;

// Implementing the first row of the Karnaugh map
andGate u1(w1, ~c, ~d);
andGate u2(w2, c, ~d);
andGate u3(w3, c, d);
orGate u4(w4, w1, w2, w3);
anDecoder u5(mux_in[0], w4);

// Implementing the second row of the Karnaugh map
andGate u6(w1, ~c, d);
andGate u7(w2, ~c, ~d);
andGate u8(w3, c, d);
orGate u9(w4, w1, w2, w3);
anDecoder u10(mux_in[1], w4);

// Implementing the third row of the Karnaugh map
andGate u11(w1, c, d);
andGate u12(w2, ~c, d);
andGate u13(w3, c, ~d);
orGate u14(w4, w1, w2, w3);
anDecoder u15(mux_in[2], w4);

// Implementing the fourth row of the Karnaugh map
andGate u16(w1, c, ~d);
andGate u17(w2, ~c, ~d);
andGate u18(w3, ~c, d);
orGate u19(w4, w1, w2, w3);
anDecoder u20(mux_in[3], w4);

endmodule
module andGate (z, x, y);
    output z;
    input x, y;
    assign z = x & y;
endmodule
module orGate (z, x, y, w);
    output z;
    input x, y, w;
    assign z = x | y | w;
endmodule
module anDecoder (z, x);
    output z;
    input [3:0] x;
    assign z = x;
endmodule
