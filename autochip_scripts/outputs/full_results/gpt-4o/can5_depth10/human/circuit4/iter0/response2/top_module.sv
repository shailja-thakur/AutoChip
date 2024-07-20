module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = (b & ~a) | (c & ~a) | (c & b) | (c & d);
endmodule
