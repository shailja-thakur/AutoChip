module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire w1, w2, w3, w4, w5;

assign w1 = ~d;
assign w2 = b & c;
assign w3 = a & w1;
assign w4 = a & b;
assign w5 = w3 | w2 | w4;
assign q = w5;

endmodule
