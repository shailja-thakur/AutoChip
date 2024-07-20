module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // Create intermediate signals for calculations
    logic intermediate1;
    
    // Perform XOR operation on in1 and in2
    assign intermediate1 = in1 ^ in2;
    
    // Perform bitwise NOT operation on intermediate1
    assign intermediate1 = ~ intermediate1;
    
    // Perform XOR operation of intermediate1 and in3 to get the final output
    assign out = intermediate1 ^ in3;

endmodule
