module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic intermediate;

    // Calculate the bitwise XOR of in1 and in2
    assign intermediate = in1 ^ in2;

    // Perform the bitwise NOT operation on the result
    assign out = ~intermediate;

    // Perform the final bitwise XOR with in3
    assign out = out ^ in3;

endmodule
