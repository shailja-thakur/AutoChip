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
    assign out_pos = (a | b | ~c | ~d) & (a | ~b | c | ~d) & (~a | b | c | d) & (~a | b | c | ~d) & (~a | ~b | ~c | d) &
                     (a | b | ~d) & (a | ~b | d) & (~a | ~b | ~c);

endmodule
