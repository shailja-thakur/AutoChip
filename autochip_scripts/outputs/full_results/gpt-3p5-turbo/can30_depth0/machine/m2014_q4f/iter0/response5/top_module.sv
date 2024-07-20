module top_module (
    input in1,
    input in2,
    output logic out
);

    // Internal signal to store the logical NOT of in2
    wire not_in2;
    
    // Assign the logical NOT of in2 to not_in2
    assign not_in2 = ~in2;
    
    // Assign the logical AND of in1 and not_in2 to out
    assign out = in1 & not_in2;
    
endmodule
