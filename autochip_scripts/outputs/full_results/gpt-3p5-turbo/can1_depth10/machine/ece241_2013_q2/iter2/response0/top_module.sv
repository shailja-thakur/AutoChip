module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Wire declarations
    wire sop0, sop1, sop2;
    wire pos0, pos1;

    // SOP expressions
    assign sop0 = c & d;
    assign sop1 = (~a & ~b & c);
    assign sop2 = sop0 | sop1;
    assign out_sop = sop2;

    // POS expressions
    assign pos0 = c & (~b | d);
    assign pos1 = (~a & d) | (~a & b);
    assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
