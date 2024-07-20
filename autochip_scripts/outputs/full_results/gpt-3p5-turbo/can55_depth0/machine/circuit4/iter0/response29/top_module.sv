module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    // Logic gate to calculate q
    assign q = b | c;

endmodule
