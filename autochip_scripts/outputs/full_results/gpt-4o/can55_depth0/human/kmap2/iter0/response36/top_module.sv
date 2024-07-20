module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // Wire all inputs to the minterms based on the given K-map
    assign out = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (~a & b & d) |
                 (a & b & ~c & d) | (a & b & c & ~d) | (a & ~b & c & ~d) | (~a & ~b & c & d) |
                 (a & b & c & d) | (a & ~b & c & d) | (a & b & ~c & d);
                 
endmodule
