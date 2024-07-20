module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (d & ~c) | (c & ~b & ~a) | (b & a);

endmodule
