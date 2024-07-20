module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic intermediate;

    // Perform the bitwise XOR operation on in1 and in2
    assign intermediate = in1 ^ in2;

    // Perform the bitwise NOT operation on the result
    assign intermediate = ~intermediate;

    // Perform the final bitwise XOR operation with in3
    assign out = intermediate ^ in3;

endmodule
