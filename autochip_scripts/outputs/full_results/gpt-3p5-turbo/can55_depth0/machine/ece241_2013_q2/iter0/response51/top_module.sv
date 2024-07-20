module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    wire sop_and, sop_not_a, sop_not_b, sop_not_c, pos0, pos1;

    assign sop_and = c & d;
    assign sop_not_a = ~a;
    assign sop_not_b = ~b;
    assign sop_not_c = ~c;

    assign out_sop = sop_and | (sop_not_a & sop_not_b & c);

    assign pos0 = c & (sop_not_b | d) & (sop_not_a | b);
    assign pos1 = c & (sop_not_a | d);
    assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;
endmodule
