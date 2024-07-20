module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic tmp;

    // Perform bitwise XOR operation on in1 and in2
    logic tmp_xor;
    assign tmp_xor = in1 ^ in2;

    // Perform bitwise NOT operation on the result
    assign tmp = ~tmp_xor;

    // Perform another bitwise XOR operation with in3
    assign out = tmp ^ in3;

endmodule
