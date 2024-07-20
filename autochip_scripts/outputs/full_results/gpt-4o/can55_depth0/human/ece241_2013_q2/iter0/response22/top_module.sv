module top_module(
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-Products (SOP) Form for the minterms 2, 7, 15
    assign out_sop = (~a & b & ~c & d) | (a & b & c & d) | (a & b & c & ~d);
    
    // Product-of-Sums (POS) Form for the maxterms 0, 1, 4, 5, 6, 9, 10, 13, 14
    assign out_pos = (a | b | c) & (a | b | ~d) & (a | ~c | d) & (~a | b | d);
    
endmodule
