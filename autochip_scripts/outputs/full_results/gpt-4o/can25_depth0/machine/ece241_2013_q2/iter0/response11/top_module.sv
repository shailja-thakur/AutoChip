module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) output
    assign out_sop = (c & d) | (~a & ~b & c);

    // Intermediate wires for Product-of-Sums (POS) output
    wire pos0, pos1;

    // Calculate the intermediate POS values
    assign pos0 = c & ((~b) | d) & ((~a) | b);
    assign pos1 = c & ((~b) | d) & ((~a) | d);

    // Final POS output using a ternary operator
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
