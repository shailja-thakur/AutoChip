module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire [0:3] m;

assign m[0] = (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & b & ~c & d) | (a & ~b & ~c & d);
assign m[1] = (~a & ~b & c & d) | (~a & b & ~c & ~d) | (a & ~b & c & d);
assign m[2] = (~a & b & c & d) | (a & b & ~c & d) | (a & b & c & ~d) | (a & b & c & d);
assign m[3] = (~a & ~b & ~c & ~d) | (~a & ~b & c & d) | (a & ~b & ~c & ~d) | (a & b & ~c & ~d);

assign out = m[0] | m[1] | m[2] | m[3];

endmodule
