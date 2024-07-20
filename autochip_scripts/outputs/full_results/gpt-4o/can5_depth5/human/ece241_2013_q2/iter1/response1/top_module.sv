module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generate the minterms for the numbers specified: 2, 7, and 15
    wire m2, m7, m15;
    assign m2 = ~a & ~b & c & ~d;
    assign m7 = ~a & b & c & d;
    assign m15 = a & b & c & d;
    
    // Sum-of-products (SOP)
    assign out_sop = m2 | m7 | m15;

    // Generate the maxterms for the other specified numbers: 0, 1, 4, 5, 6, 9, 10, 13, 14
    wire M0, M1, M4, M5, M6, M9, M10, M13, M14;
    assign M0 = ~a & ~b & ~c & ~d;
    assign M1 = ~a & ~b & ~c & d;
    assign M4 = ~a & b & ~c & ~d;
    assign M5 = ~a & b & ~c & d;
    assign M6 = ~a & b & c & ~d;
    assign M9 = a & ~b & ~c & d;
    assign M10 = a & ~b & c & ~d;
    assign M13 = a & b & ~c & d;
    assign M14 = a & b & c & ~d;

    // Product-of-sums (POS)
    assign out_pos = ~(M0 | M1 | M4 | M5 | M6 | M9 | M10 | M13 | M14);

endmodule
