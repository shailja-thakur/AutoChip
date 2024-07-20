module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (c == 1) ? 1 : 0;

endmodule
