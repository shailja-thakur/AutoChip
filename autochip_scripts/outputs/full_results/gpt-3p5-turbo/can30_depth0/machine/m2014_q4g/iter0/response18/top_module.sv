module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);
    
    // Intermediate wire to store the result of the XOR operation
    wire xor_result;
    
    // Perform XOR operation between in1 and in2
    assign xor_result = in1 ^ in2;
    
    // Perform bitwise NOT operation on xor_result
    assign out = ~xor_result;
    
    // Perform XOR operation between the result of NOT(in1 XOR in2) and in3
    assign out = out ^ in3;
    
endmodule
