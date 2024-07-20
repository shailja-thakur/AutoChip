module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire not_a = ~a;
    wire not_b = ~b;
    wire cd_and = c & d;
    wire not_a_not_b_c_and = not_a & not_b & c;

    assign out_sop = cd_and | not_a_not_b_c_and;

    wire pos0 = c & (not_b | d) & (not_a | b);
    wire pos1 = c & (not_a | d);

    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
