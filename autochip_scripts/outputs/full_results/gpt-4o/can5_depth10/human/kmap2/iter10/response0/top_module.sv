module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) |           // Covers 0000, 0100
                 (~a & ~c & ~d) |      // Covers 0000, 0001
                 (~a & b & ~d) |       // Covers 0010, 1010
                 (~a & b & c) |        // Covers 0111
                 (~a & b & ~c) |       // Covers 0010, 0110
                 (a & ~b & ~c) |       // Covers 1000
                 (a & ~b & d) |        // Covers 1011
                 (a & b & d) |         // Covers 1101, 1111
                 (a & b & ~c & ~d);    // Must match A=1, B=1, C=0, D=0
                 
endmodule
