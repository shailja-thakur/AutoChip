module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic tmp;

    // Perform bitwise XOR on in1 and in2
    assign tmp = in1 ^ in2;

    // Perform bitwise NOT on the result
    assign tmp = ~tmp;

    // Perform bitwise XOR with in3
    assign out = tmp ^ in3;

endmodule
