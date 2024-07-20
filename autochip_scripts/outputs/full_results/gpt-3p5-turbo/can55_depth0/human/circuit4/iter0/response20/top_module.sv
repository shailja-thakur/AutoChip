module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Logic implementation

    assign q = (~a & ~b & d) | (c & ~d);

endmodule
