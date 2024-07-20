module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = (b | c); // q is high when either 'b' or 'c' is high
endmodule
