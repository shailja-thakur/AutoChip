module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // q is 1 if (b and c) or (a and d) is true
    assign q = (b & c) | (a & d);

endmodule
