module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (c & d) | (~c & a & ~b) | (~c & ~a & b);

endmodule
