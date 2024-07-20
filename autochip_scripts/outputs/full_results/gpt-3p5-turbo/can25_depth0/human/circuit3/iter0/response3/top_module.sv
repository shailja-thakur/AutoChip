module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Circuit implementation
    assign q = (a & b) | (c & d);

endmodule
