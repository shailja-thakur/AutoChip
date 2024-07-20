module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-products (SOP) for the minterms 2, 7, and 15
    assign out_sop = (~a & ~b & c & ~d) | (~a & b & c & d) | (a & b & c & d);

    // Product-of-sums (POS) for the maxterms of the other specified numbers
    assign out_pos = (a | ~b | ~c | ~d) & (~a | b | ~c | ~d) & (~a | ~b | c | ~d);

endmodule
