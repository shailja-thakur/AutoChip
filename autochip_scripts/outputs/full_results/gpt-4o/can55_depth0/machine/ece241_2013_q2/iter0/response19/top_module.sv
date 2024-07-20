module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire and_cd;
    wire and_not_ab_c;
    wire pos0;
    wire pos1;

    // Compute intermediary results for SOP
    assign and_cd = c & d;
    assign and_not_ab_c = (~a) & (~b) & c;

    // Compute the final SOP result
    assign out_sop = and_cd | and_not_ab_c;

    // Compute intermediary results for POS
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~b) | d) & ((~a) | d);

    // Compute the final POS result
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
