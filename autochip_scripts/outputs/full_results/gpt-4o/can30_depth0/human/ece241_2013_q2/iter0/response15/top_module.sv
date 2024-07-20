module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Generating SOP (Sum of Products) form for the given conditions
    assign out_sop = (~a & b & ~c & d) | (a & b & c & ~d) | (a & b & c & d);

    // Generating POS (Product of Sums) form for the given conditions
    assign out_pos = (a | b | ~c | ~d) & (a | ~b | ~c | d) & (~a | b | ~c | ~d);

endmodule
