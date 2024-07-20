module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate the sop output.
    wire and_cd = c & d;
    wire not_a = ~a;
    wire not_b = ~b;
    wire and_abc = not_a & not_b & c;
    assign out_sop = and_cd | and_abc;

    // Generate the pos0 and pos1 wires for the pos output.
    wire pos0 = c & (not_b | d) & (not_a | b);
    wire pos1 = c & (not_b | d) & (not_a | d);

    // Assign the pos output based on pos0 and pos1.
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
