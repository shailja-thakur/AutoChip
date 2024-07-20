module top_module (
    input in1,
    input in2,
    output logic out
);
    
    // Declare negation signal
    logic negation;
    
    // Assign negation signal the negation of logical OR of in1 and in2
    assign negation = ~(in1 | in2);
    
    // Assign out as the negation signal
    assign out = negation;

endmodule
