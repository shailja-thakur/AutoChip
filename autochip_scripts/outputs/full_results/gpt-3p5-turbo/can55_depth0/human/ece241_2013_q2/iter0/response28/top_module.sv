module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

wire out1, out2;

assign out1 = (a & ~b & c & d) | (~a & b & ~c & d) | (~a & ~b & ~c & ~d);
assign out2 = (~(a | b | c | d)) & 4'b1111;

assign out_sop = out1;
assign out_pos = out2;

endmodule
