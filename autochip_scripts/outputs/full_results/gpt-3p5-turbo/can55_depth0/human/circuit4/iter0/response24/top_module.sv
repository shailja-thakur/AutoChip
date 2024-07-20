module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Assign the output signal 'q' based on the given input signals 'a', 'b', 'c', and 'd'
    assign q = (~a & ~b & ~c & d) | (a & ~b & c & ~d) | (a & ~b & c & d) | (a & b & ~c & d) | (a & b & c & ~d) | (a & b & c & d);

endmodule
