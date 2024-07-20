module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

wire sop_term1, sop_term2;
wire pos0, pos1;

// Compute the SOP terms
assign sop_term1 = c & d;
assign sop_term2 = ~a & ~b & c;
assign out_sop = sop_term1 | sop_term2;

// Compute the POS terms
assign pos0 = c & (~b | d) & (~a | b);
assign pos1 = c & (~b | d) & (~a | d);

assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
