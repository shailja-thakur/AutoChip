module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

// SOP expression
wire sop1 = c & d;
wire sop2 = (~a & ~b & ~c) | (c & d);
assign out_sop = sop1 | sop2;

// POS expression
wire pos0 = c & (~b | d) & (~a | b);
wire pos1 = c & (~a | d);
assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
