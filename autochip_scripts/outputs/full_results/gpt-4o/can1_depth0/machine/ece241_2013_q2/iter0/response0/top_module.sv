module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate the out_sop output
    wire sop1, sop2;
    assign sop1 = c & d;
    assign sop2 = (~a) & (~b) & c;
    assign out_sop = sop1 | sop2;

    // Generate pos0 and pos1 for out_pos
    wire pos0, pos1;
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~b) | d) & ((~a) | d);

    // Assign out_pos based on the value of pos0 and pos1
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
