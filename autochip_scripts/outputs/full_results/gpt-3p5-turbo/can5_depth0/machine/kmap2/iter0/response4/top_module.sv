module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);

    // Logic implementation
    assign out = (~c & ~b) | (~d & ~a) | (a & c & d) | (b & c & d);

endmodule
