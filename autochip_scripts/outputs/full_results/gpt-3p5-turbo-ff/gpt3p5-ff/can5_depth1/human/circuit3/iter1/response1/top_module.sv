module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire w1, w2, w3, w4, w5;

assign w1 = (b & c) | (c & d);
assign w2 = a & ~c & d;
assign w3 = a & ~b & c;
assign w4 = ~a & ~b & d;
assign w5 = (w1 | w2 | w3 | w4) & (a | c);

assign q = w5;

endmodule
