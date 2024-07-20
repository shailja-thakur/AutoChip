module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire sop0, sop1;
    wire not_a, not_b;
    wire pos0, pos1;

    // Compute intermediate values for SOP
    assign not_a = ~a;
    assign not_b = ~b;
    assign sop0 = c & d;
    assign sop1 = not_a & not_b & c;
    assign out_sop = sop0 | sop1;

    // Compute intermediate values for POS
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~b | d) & (~a | d);

    // Conditional assignment to out_pos
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
