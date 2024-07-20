module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (b == 0 && c == 0 && d == 1) || 
           (b == 0 && c == 1 && d == 0) || 
           (b == 0 && c == 1 && d == 1) || 
           (b == 1 && c == 0 && d == 1) || 
           (b == 1 && c == 1 && d == 0) || 
           (b == 1 && c == 1 && d == 1);

endmodule
