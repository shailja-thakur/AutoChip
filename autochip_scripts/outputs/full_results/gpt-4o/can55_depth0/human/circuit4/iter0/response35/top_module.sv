module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (c == 1'b1) | (b == 1'b1);

endmodule
