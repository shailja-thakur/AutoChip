module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire ab_00, ab_01, ab_11, ab_10;

assign ab_00 = (~a & ~b) | (a & b);
assign ab_01 = (~a & b) | (a & ~b);
assign ab_11 = (a & b);
assign ab_10 = (a & ~b) | (~a & b);

assign out = (c & d & ab_11) | (c & ~d & ab_01) | (~c & d & ab_10) | (~c & ~d & ab_00);

endmodule
