module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (d && (a || b)) || (b && c);

endmodule
