module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    // Declare intermediate wires
    wire not_a, not_b;
    wire sop1, sop2;
    wire pos0, pos1;

    // Calculate inverted inputs
    assign not_a = ~a;
    assign not_b = ~b;

    // Calculate SOP expression
    assign sop1 = c & d;
    assign sop2 = not_a & not_b & c;
    assign out_sop = sop1 | sop2;

    // Calculate POS expression intermediates
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_b | d) & (not_a | d);

    // Combine POS expression results
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
