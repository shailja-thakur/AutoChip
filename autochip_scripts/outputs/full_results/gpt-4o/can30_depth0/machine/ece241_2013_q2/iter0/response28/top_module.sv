module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    wire sop_and1;
    wire sop_and2;
    wire pos0;
    wire pos1;

    // Generate the SOP output
    assign sop_and1 = c & d;
    assign sop_and2 = ~a & ~b & c;
    assign out_sop = sop_and1 | sop_and2;

    // Generate the POS intermediate wires
    assign pos0 = c & (~b | d) & (~a | b);
    assign pos1 = c & (~a | d);

    // Assign the out_pos based on pos0 and pos1
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
