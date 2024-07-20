module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum-of-products (SOP) form
    assign out_sop = (~a & b & ~c & d) | (a & b & c & d) | (a & b & ~c & ~d);

    // Product-of-sums (POS) form
    assign out_pos = (b | ~c | ~d) & (a | ~b | ~c | d);

endmodule
