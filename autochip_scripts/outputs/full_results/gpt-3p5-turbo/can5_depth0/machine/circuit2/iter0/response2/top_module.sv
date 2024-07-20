module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Wire to store intermediate result of XOR operation
    wire xor_result;

    // Perform XOR operation on the input signals
    assign xor_result = a ^ b ^ c ^ d;

    // Invert the result to get the final output
    assign q = ~xor_result;

endmodule
