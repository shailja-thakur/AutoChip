module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic temp;

    // Calculate (in1 XOR in2)
    assign temp = in1 ^ in2;

    // Perform bitwise NOT operation on the result
    assign out = ~temp;

    // Perform bitwise XOR operation with in3
    assign out = out ^ in3;

endmodule
