module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire w1, w2, w3, w4, w5, w6, w7, w8;

assign w1 = a & b;
assign w2 = b & c;
assign w3 = b & d;
assign w4 = c & d;
assign w5 = a & c;
assign w6 = a & d;
assign w7 = w1 | w2 | w3 | w4;
assign w8 = w5 | w6;

assign q = ~(w7 & w8);

endmodule
