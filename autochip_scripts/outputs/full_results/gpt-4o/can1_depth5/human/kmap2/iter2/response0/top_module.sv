module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    // The Karnaugh map can be translated into the following minimized boolean expression:
    // out = ~a~b~c + ~a~b~d + ~a~c~d + ~a~cd + ~ab~cd + a~bcd + abc~d

    assign out = (~a & ~b & ~c) | (~a & ~b & d) | (~a & c & ~d) |
                 (~a & c & d) | (a & ~b & ~c & d) | (a & ~b & c & d) |
                 (a & b & c & ~d);

endmodule
