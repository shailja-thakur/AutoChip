module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    wire xor_result;

    assign xor_result = in1 ^ in2;
    assign out = ~xor_result ^ in3;

endmodule
