module top_module (
    input in1,
    input in2, 
    input in3,
    output logic out
);

    logic temp;

    // Calculate the bitwise XOR of in1 and in2
    assign temp = in1 ^ in2;

    // Perform a bitwise NOT operation on the result
    assign temp = ~temp;

    // Perform a bitwise XOR operation with in3
    assign out = temp ^ in3;

endmodule
