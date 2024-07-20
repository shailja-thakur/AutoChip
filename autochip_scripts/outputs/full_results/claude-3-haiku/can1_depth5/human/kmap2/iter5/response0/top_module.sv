module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (a & ~b & ~c) | (a & c) | (b & d);

endmodule
