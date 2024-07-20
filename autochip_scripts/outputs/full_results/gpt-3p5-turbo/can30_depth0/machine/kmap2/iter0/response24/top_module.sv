module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = ((~c & ~b) | (~d & ~a) | (a & c & d) | (b & c & d)) ? 1'b1 : 1'b0;

endmodule
