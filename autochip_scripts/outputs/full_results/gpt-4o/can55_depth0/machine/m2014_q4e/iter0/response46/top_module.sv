module top_module (
    input in1,
    input in2,
    output logic out
);

    // Logical OR of the inputs
    wire or_result;
    assign or_result = in1 | in2;
    
    // Logical negation of the OR result
    assign out = ~or_result;

endmodule
