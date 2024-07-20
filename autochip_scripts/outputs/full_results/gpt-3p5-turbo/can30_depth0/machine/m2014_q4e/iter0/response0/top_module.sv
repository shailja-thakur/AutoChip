module top_module (
    input in1,
    input in2,
    output logic out
);

    // Declare intermediate wire for OR operation
    wire or_result;

    // Perform OR operation
    assign or_result = in1 | in2;

    // Perform negation and assign to output
    assign out = ~or_result;

endmodule
