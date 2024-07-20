module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate out_sop (Sum-of-Products)
    wire sop_and1 = c & d;
    wire sop_and2 = (~a) & (~b) & c;
    assign out_sop = sop_and1 | sop_and2;
    
    // Generate pos0 and pos1
    wire pos0 = c & ((~b) | d) & ((~a) | b);
    wire pos1 = c & ((~b) | d) & ((~a) | d);
    
    // Generate out_pos (Product-of-Sums)
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
