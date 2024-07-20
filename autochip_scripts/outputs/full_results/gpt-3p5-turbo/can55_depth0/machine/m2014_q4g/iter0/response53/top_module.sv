module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);
   
    // Intermediate wires for calculations
    wire xor_result;
    wire not_result;
   
    // XOR operation between in1 and in2
    assign xor_result = in1 ^ in2;
   
    // Bitwise NOT operation on xor_result
    assign not_result = ~xor_result;
   
    // XOR operation between not_result and in3
    assign out = not_result ^ in3;
   
endmodule
