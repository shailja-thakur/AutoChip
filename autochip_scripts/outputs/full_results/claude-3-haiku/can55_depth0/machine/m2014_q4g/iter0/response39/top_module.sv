module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic temp;

    // Perform XOR operation on in1 and in2
    assign temp = in1 ^ in2;

    // Perform bitwise NOT operation on the result
    assign temp = ~temp;

    // Perform another XOR operation with in3
    assign out = temp ^ in3;

endmodule
