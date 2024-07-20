module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    wire not_a;
    wire not_b;
    wire sop1;
    wire sop2;
    wire pos0;
    wire pos1;

    // Invert the inputs a and b
    assign not_a = ~a;
    assign not_b = ~b;

    // Generate the out_sop as a Sum-of-Products (SOP) expression
    assign sop1 = c & d;
    assign sop2 = not_a & not_b & c;
    assign out_sop = sop1 | sop2;

    // Generate the pos0 and pos1 intermediate wires for out_pos
    assign pos0 = c & (not_b | d) & (not_a | b);
    assign pos1 = c & (not_b | d) & (not_a | d);

    // Generate the out_pos as a Product-of-Sums (POS) expression
    assign out_pos = (pos0 === pos1) ? pos0 : 1'bx;

endmodule
