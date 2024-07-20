module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic temp;

    // Perform bitwise XOR on in1 and in2
    assign temp = in1 ^ in2;

    // Perform bitwise NOT on the result
    assign temp = ~temp;

    // Perform another bitwise XOR with in3
    assign out = temp ^ in3;

endmodule
