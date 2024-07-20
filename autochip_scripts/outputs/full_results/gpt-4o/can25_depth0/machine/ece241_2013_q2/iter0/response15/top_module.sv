module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    wire w1, w2, pos0, pos1;

    // Generating out_sop using Sum-of-Products (SOP) expression
    assign w1 = c & d;
    assign w2 = (~a & ~b & c);
    assign out_sop = w1 | w2;

    // Generating out_pos using Product-of-Sums (POS) expression
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);

    // Ternary expression to assign out_pos
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
