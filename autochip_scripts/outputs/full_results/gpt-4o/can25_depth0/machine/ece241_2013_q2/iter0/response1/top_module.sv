module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generating out_sop (Sum-of-Products)
    wire sop0, sop1;
    assign sop0 = c & d;
    assign sop1 = ~a & ~b & c;
    assign out_sop = sop0 | sop1;
    
    // Generating out_pos (Product-of-Sums)
    wire pos0, pos1;
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
