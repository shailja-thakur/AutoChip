module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Boolean expression derived from K-map:
    // out = (c'd') + (cd') + (cd) + (b'cd') + (acd')

    assign out = (c & d & ~b) | (~c & ~d) | (~a & c & ~d) | (a & ~c & d) | (a & c & ~d);

endmodule
