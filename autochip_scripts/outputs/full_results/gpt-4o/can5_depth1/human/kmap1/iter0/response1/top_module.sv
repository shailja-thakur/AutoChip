module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Intermediate signals
    wire not_a, not_b, not_c;
    wire term1, term2, term3, term4, term5, term6;

    // Generate inverted inputs
    assign not_a = ~a;
    assign not_b = ~b;
    assign not_c = ~c;

    // Generate terms for the Karnaugh map cover
    assign term1 = not_b & not_c & a; // when bc = 00 and a = 1
    assign term2 = not_b & c;         // when bc = 01
    assign term3 = b & not_c;         // when bc = 10
    assign term4 = b & c;             // when bc = 11
    assign term5 = b & not_a;
    assign term6 = c & not_a;
    
    // Combining terms to get the output
    assign out = term1 | term2 | term3 | term4 | term5 | term6;

endmodule
