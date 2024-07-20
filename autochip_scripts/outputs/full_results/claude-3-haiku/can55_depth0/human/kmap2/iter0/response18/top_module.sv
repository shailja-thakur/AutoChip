module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

wire ab00, ab01, ab11, ab10;

assign ab00 = (~a & ~b) | (a & ~b);
assign ab01 = (~a & b) | (a & b);
assign ab11 = (a & b);
assign ab10 = (a & ~b) | (~a & b);

assign out = (ab00 & ~c & ~d) | (ab01 & ~c & d) | (ab11 & c & d) | (ab10 & c & ~d);

endmodule
