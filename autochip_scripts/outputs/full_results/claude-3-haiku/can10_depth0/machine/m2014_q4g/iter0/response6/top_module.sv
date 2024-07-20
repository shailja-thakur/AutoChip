module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic intermediate;

    // Perform bitwise XOR operation on in1 and in2
    assign intermediate = in1 ^ in2;

    // Perform bitwise NOT operation on the result
    assign out = ~intermediate;

    // Perform another bitwise XOR operation with in3
    assign out = out ^ in3;

endmodule
