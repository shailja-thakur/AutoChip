module top_module (
    input  wire in1,
    input  wire in2,
    input  wire in3,
    output logic out
);

    logic temp;

    // Calculate (in1 XOR in2)
    assign temp = in1 ^ in2;

    // Perform bitwise NOT on the result
    assign temp = ~temp;

    // Perform another XOR with in3
    assign out = temp ^ in3;

endmodule
