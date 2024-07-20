module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire w1, w2, w3;

assign w1 = ~(a & b & c & d);
assign w2 = ~(a & b & c & ~d);
assign w3 = (a ^ b ^ c ^ d);

assign q = ((w1 & w2) | w3);

endmodule
