module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate the out_sop output (Sum of Products)
    wire sop0 = c & d;
    wire sop1 = (~a) & (~b) & c;
    assign out_sop = sop0 | sop1;

    // Generate the out_pos output (Product of Sums)
    wire pos0 = c & ((~b) | d) & ((~a) | b);
    wire pos1 = c & ((~a) | d) & ((~a) | b);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
