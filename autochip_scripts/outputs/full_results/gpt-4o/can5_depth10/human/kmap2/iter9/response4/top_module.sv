module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) |           // Covers 0000, 0100, 1000
                 (~a & ~c & b) |       // Covers 0001, 1001
                 (~a & b & ~d) |       // Covers 0010, 1010, 0110
                 (~a & b & c) |        // Covers 0111
                 (a & ~b & ~c & ~d) |  // Covers 1000
                 (a & b & c & d) |     // Covers 1111
                 (a & b & ~c) |        // Covers 1101, 1110
                 (a & ~b & d);         // Covers 1011
                 
endmodule
