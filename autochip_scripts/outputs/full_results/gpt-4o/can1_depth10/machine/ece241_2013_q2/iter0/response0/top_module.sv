module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Calculate out_sop (Sum-of-Products)
    wire and1, and2;
    assign and1 = c & d;
    assign and2 = ~a & ~b & c;
    assign out_sop = and1 | and2;

    // Calculate out_pos (Product-of-Sums)
    wire pos0, pos1;
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
