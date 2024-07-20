module top_module (
    input in1,
    input in2,
    output logic out
);
    
    assign out = in1 & ~in2; // logical AND of in1 and the logical NOT of in2

endmodule
