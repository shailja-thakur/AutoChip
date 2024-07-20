module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic temp;

    // Perform the bitwise XOR operation on in1 and in2
    assign temp = in1 ^ in2;

    // Perform the bitwise NOT operation on the result
    assign temp = ~temp;

    // Perform the final bitwise XOR operation with in3
    assign out = temp ^ in3;

endmodule
