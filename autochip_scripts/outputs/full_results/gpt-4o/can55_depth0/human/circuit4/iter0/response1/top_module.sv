module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = (b == 1'b1) || (c == 1'b1) || ((a == 1'b0) && (d == 1'b0));
endmodule
