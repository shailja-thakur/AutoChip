module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire x1, x2, x3, x4;

assign x1 = (~a & ~b & c & d) | (a & ~b & ~c & d) | (~a & b & ~c & d) | (a & b & c & ~d);
assign x2 = (~a & ~b & c & d) | (a & ~b & ~c & d) | (a & b & ~c & ~d) | (a & b & c & ~d);
assign x3 = (~a & b & c & ~d) | (a & b & c & d) | (a & b & ~c & d);
assign out = x1 | x2 | x3;

endmodule
