module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    // Generate Sum-of-Products (SOP) expression
    wire sop1, sop2;
    assign sop1 = c & d;
    assign sop2 = (~a & ~b & c);
    assign out_sop = sop1 | sop2;

    // Generate Product-of-Sums (POS) expression
    wire pos0, pos1;
    assign pos0 = (c & (~b | d) & (~a | b));
    assign pos1 = (c & (~b | d) & (~a | d));
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
