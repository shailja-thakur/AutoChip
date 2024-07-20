module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    assign q = (a & b) | (a & c) | (a & d) | (b & d) | (c & b) | (c & d);

endmodule
