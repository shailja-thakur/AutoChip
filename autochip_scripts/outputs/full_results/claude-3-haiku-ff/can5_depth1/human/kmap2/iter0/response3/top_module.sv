module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire w1, w2, w3, w4;

assign w1 = (a & b) | (~a & ~b & c) | (~a & b & ~d); 
assign w2 = (~a & b) | (a & ~b & c) | (a & b & d);
assign w3 = (a & ~b) | (a & b) | (~a & b & d);
assign w4 = (~a & ~b & ~d) | (~a & b & d) | (a & ~b & ~d) | (a & b & c);

assign out = w1 | w2 | w3 | w4;

endmodule
