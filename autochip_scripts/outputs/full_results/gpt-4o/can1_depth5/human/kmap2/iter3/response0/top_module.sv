module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    // Deriving the correct boolean expression from the Karnaugh map:
    // out = ~a~b + ~a~c~d + ~b~d + ~bc + acd

    assign out = (~a & ~b) | (~a & ~c & ~d) | (~b & ~d) | (~b & c) | (a & c & d);

endmodule
