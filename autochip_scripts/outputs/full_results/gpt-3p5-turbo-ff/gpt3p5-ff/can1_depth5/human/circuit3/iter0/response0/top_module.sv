module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);
    wire q;

    assign q = (~(a & b) & (~c & d) | (b & c) & d);

endmodule
