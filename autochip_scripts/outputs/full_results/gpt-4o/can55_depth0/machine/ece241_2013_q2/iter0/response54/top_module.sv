module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Logic for out_sop (Sum-of-Products)
    assign out_sop = (c & d) | (~a & ~b & c);

    // Wires for intermediate POS results
    wire pos0, pos1;

    // Logic for out_pos (Product-of-Sums)
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);

    // Final out_pos output
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
