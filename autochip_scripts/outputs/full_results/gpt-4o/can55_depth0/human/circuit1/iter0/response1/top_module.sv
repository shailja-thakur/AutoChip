module top_module (
    input a,
    input b,
    output q
);

    // The output q should be the AND of inputs a and b
    assign q = a & b;
    
endmodule
