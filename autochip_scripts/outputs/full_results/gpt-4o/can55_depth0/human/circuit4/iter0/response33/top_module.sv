module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = (b == 1'b1) | (c & ~a);
endmodule
