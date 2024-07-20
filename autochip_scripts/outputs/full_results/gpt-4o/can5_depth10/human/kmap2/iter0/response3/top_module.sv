module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // Create a truth table for the given Karnaugh map:
    // out = f(a, b, c, d) = Σ(0, 1, 3, 4, 7, 8, 9, 10, 11, 15)
    // Using Karnaugh map simplification, 
    // the simplified Boolean expression for the given map is:
    // F = a'd' + b'c + ac'd + bd

    assign out = (~a & ~d) | (~b & c) | (a & ~c & d) | (b & d);

endmodule
