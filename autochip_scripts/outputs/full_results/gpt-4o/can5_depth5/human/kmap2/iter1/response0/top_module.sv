module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Using the Karnaugh map, derive the minimized Boolean expression
    // The expression is:
    // F = (~c & ~d) | (~b & ~c) | (a & ~d) | (a & b & c)

    assign out = (~c & ~d) | (~b & ~c) | (a & ~d) | (a & b & c);

endmodule
