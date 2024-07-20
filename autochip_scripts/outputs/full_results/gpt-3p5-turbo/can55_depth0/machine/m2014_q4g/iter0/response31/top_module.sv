module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // XOR operation between in1 and in2
    logic xor_result;
    assign xor_result = in1 ^ in2;

    // NOT operation on the xor_result
    logic not_result;
    assign not_result = ~xor_result;

    // Final XOR operation with in3
    assign out = not_result ^ in3;

endmodule
