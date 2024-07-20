module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire sop_term1, sop_term2;
    wire pos0, pos1;

    // Generate out_sop
    assign sop_term1 = c & d;
    assign sop_term2 = (~a) & (~b) & c;
    assign out_sop = sop_term1 | sop_term2;

    // Generate out_pos
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~a) | d);
    assign out_pos = (pos0 & pos1) ? 1'b1 : 1'b0;
endmodule
