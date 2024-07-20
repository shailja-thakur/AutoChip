module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire sop_1;
    wire sop_2;
    wire pos_0;
    wire pos_1;

    // SOP expression
    assign sop_1 = c & d;
    assign sop_2 = (~a & ~b & c);
    assign out_sop = sop_1 | sop_2;

    // POS expression
    assign pos_0 = c & (~b | d) | (~a & b);
    assign pos_1 = c & (~a | d);

    assign out_pos = (pos_0 === pos_1) ? pos_0 : 1'bX;

endmodule
