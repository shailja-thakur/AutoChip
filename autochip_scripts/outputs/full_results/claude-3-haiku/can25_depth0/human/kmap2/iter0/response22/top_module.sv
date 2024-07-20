module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire n1, n2, n3, n4;

assign n1 = (~a & ~b & c & d) | (a & ~b & ~c & d) | (~a & b & c & ~d) | (a & b & ~c & d);
assign n2 = (~a & b & ~c & d) | (a & ~b & c & d) | (a & b & ~c & ~d);
assign n3 = (~a & b & c & d) | (a & ~b & c & d) | (a & b & c & ~d) | (a & b & c & d);
assign n4 = (~a & ~b & ~c & d) | (a & ~b & ~c & ~d);

assign out = n1 | n2 | n3 | n4;

endmodule
