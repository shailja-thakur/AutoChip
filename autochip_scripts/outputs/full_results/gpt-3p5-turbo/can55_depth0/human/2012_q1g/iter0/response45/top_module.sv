module top_module (
	input [4:1] x,
	output logic f
);
    //---------------------- INPUT DECODER SECTION -----------------------
    wire w1,w2,w3,w4,w5,w6,w7,w8;
    assign w1 = |x;
    assign w2 = x[1] & |x[2:1];
    assign w3 = |x[3:2];
    assign w4 = x[1:0] & |x[3];
    assign w5 = |x[3:1];
    assign w6 = x[2] & |x[4:3];
    assign w7 = x[1] & |x[4:2];
    assign w8 = x[2:0] & |x[4];
    
    //---------------------- AND GATE SECTION -----------------------------
    wire w9, w10, w11, w12, w13, w14, w15, w16;
    assign w9 = w1 & w2;
    assign w10 = w3 & w4;
    assign w11 = w5 & w6;
    assign w12 = w7 & w8;
    
    //---------------------- OR GATE SECTION ------------------------------
    assign f = w9 | w10 | w11 | w12;
endmodule
