module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire w1, w2, w3, w4;

assign w1 = (~a & ~b & c & d) | (a & ~b & c & d) | (a & b & ~c & d) | (~a & b & c & ~d);
assign w2 = (~a & ~b & c & d) | (a & ~b & c & d) | (a & b & c & ~d) | (~a & b & c & d);
assign w3 = (a & b & c & ~d) | (a & b & ~c & d) | (a & b & c & d);
assign w4 = (~a & ~b & c & d) | (a & ~b & c & ~d) | (a & b & ~c & ~d) | (~a & b & ~c & ~d);

assign out = w1 | w2 | w3 | w4;

endmodule
