module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // Assign intermediate signals
    logic intermediate1;
    logic intermediate2;

    // Perform bitwise XOR operation between in1 and in2
    assign intermediate1 = in1 ^ in2;

    // Perform bitwise NOT operation on intermediate1
    assign intermediate2 = ~intermediate1;

    // Perform bitwise XOR operation between intermediate2 and in3
    assign out = intermediate2 ^ in3;

endmodule
