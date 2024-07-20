module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    wire w1, w2, w3, w4;

    // Implement the Karnaugh map
    assign w1 = (~a & ~b & ~c) | (~a & b & ~c) | (a & ~b & c) | (a & b & ~c);
    assign w2 = (~a & ~b & c) | (~a & b & c) | (a & ~b & ~c) | (a & b & c);
    assign w3 = (~a & b & c) | (a & ~b & c) | (a & b & ~c) | (a & b & c);
    assign w4 = (~a & ~b & ~c) | (~a & b & ~c) | (a & ~b & ~c) | (a & b & c);

    assign out = w1 | w2 | w3 | w4;

endmodule
