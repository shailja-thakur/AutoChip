module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire m1, m2, m3, m4;

assign m1 = (~a & ~b & c & ~d) | (~a & b & ~c & ~d) | (a & ~b & c & d) | (a & b & ~c & d);
assign m2 = (~a & ~b & c & d) | (~a & b & ~c & d) | (a & ~b & ~c & d) | (a & b & c & ~d);
assign m3 = (~a & b & c & d) | (a & ~b & c & d) | (a & b & ~c & d) | (a & b & c & d);
assign m4 = (~a & ~b & ~c & ~d) | (~a & b & c & ~d) | (a & ~b & ~c & d) | (a & b & ~c & ~d);

assign out = m1 | m2 | m3 | m4;

endmodule
