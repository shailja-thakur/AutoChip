module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic tmp;

    // Perform the bitwise XOR operation on in1 and in2
    assign tmp = in1 ^ in2;

    // Perform the bitwise NOT operation on the result
    assign tmp = ~tmp;

    // Perform the final bitwise XOR operation with in3
    assign out = tmp ^ in3;

endmodule
