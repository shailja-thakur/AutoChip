module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    // Deriving the correct boolean equation from the given Karnaugh map:
    // Using Sum of Minterms based on the provided Karnaugh map:
    // out = Σ(0, 1, 2, 4, 7, 8, 10, 11, 13, 14, 15)
    // Writing the Minterms as expressions, each one represents a combination of inputs giving '1'
    assign out = (~a & ~b & ~c & ~d) |
                 (~a & ~b & ~c &  d) |
                 (~a &  b & ~c & ~d) |
                 (~a &  b &  c &  d) |
                 ( a &  b & ~c &  d) |
                 ( a & ~b & ~c & ~d) |
                 ( a &  b &  c &  d) |
                 ( a &  b &  c & ~d) |
                 (~a &  b &  c & ~d) |
                 (~a & ~b &  c &  d);

endmodule
