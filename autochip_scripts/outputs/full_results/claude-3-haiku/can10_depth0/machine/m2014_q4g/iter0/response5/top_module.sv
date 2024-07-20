module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic intermediate;

    // Perform bitwise XOR on in1 and in2
    assign intermediate = in1 ^ in2;

    // Perform bitwise NOT on the result
    assign intermediate = ~intermediate;

    // Perform bitwise XOR with in3
    assign out = intermediate ^ in3;

endmodule
