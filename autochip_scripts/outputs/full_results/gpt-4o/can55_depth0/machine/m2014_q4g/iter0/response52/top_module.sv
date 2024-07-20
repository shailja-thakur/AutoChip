module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);
    logic xor_result, not_result;
    
    // Perform XOR on in1 and in2
    assign xor_result = in1 ^ in2;
    
    // Perform NOT on the XOR result
    assign not_result = ~xor_result;
    
    // Perform XOR with in3
    assign out = not_result ^ in3;
    
endmodule
