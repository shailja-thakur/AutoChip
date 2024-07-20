module top_module (
    input a, 
    input b, 
    output q
);

    // q is high only when both a and b are high
    assign q = a & b;

endmodule
