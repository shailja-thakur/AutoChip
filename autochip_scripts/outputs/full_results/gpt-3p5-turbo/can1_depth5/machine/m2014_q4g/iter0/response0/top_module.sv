module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // Perform the XOR operation on in1 and in2
    wire xor_result;
    assign xor_result = in1 ^ in2;

    // Perform the bitwise NOT operation on the XOR result
    wire not_result;
    assign not_result = ~xor_result;

    // Perform the XOR operation on the inverted result and in3
    assign out = not_result ^ in3;

endmodule
