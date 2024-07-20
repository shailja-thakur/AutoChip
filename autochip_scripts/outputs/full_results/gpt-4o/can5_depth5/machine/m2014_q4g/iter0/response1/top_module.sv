module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);
    logic intermediate_result;

    // Perform the XOR operation on in1 and in2
    assign intermediate_result = in1 ^ in2;

    // Perform the NOT operation on the intermediate result
    assign intermediate_result = ~intermediate_result;

    // Perform the XOR operation with in3 to get the final output
    assign out = intermediate_result ^ in3;

endmodule
