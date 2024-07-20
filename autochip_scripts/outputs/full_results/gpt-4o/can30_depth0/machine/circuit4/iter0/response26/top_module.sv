module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    
    // Assign q to be the logical OR of inputs b and c
    assign q = b | c;

endmodule
