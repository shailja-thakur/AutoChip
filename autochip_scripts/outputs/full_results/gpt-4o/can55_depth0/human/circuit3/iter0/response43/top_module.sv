module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (b & ~a) | (d & a & ~b) | (c & ~a & b) | (d & a & b) | (c & d);

endmodule
