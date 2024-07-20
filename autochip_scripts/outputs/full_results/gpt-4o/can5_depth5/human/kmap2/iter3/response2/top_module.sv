module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Implementing the circuit using the Karnaugh map
    // out = Σm(0, 1, 3, 4, 7, 11, 12, 13, 14)
    assign out = (~a & ~b & ~c & ~d) |  // m(0)
                 (~a & ~b & ~c & d)  |  // m(1)
                 (~a & b & ~c & d)   |  // m(3)
                 (a & ~b & ~c & ~d)  |  // m(4)
                 (a & b & b & c & d) |  // m(7)
                 (a & b & c & ~d)    |  // m(11)
                 (a & ~b & c & ~d)   |  // m(12)
                 (a & ~b & c & d)    |  // m(13)
                 (a & ~b & ~c & d);     // m(14)

endmodule
