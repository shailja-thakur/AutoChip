module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);
    
    // Intermediate wires for the calculation
    wire not_a = ~a;
    wire not_b = ~b;
    wire not_a_and_not_b_and_c = not_a & not_b & c;
    wire c_and_d = c & d;
    
    // Sum-of-Products (SOP) Expression
    assign out_sop = c_and_d | not_a_and_not_b_and_c;

    // Intermediate wires for the Product-of-Sums (POS) calculation
    wire pos0 = c & ((~b) | d) & ((~a) | b);
    wire pos1 = c & ((~b) | d) & ((~a) | d);

    // Product-of-Sums (POS) Expression
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
