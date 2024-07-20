module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire not_a, not_b, not_c, not_d;
    wire sop_expr, pos0, pos1;

    assign not_a = ~a;
    assign not_b = ~b;
    assign not_c = ~c;
    assign not_d = ~d;

    assign sop_expr = (c & d) | (not_a & not_b & c);

    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = (not_a | d) & (not_b | c);

    assign out_sop = sop_expr;
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bX;

endmodule
