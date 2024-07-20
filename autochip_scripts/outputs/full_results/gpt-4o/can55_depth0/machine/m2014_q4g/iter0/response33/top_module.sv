module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);
    logic temp;
    
    assign temp = in1 ^ in2; // Perform bitwise XOR on in1 and in2
    assign out = ~temp ^ in3; // Perform bitwise NOT on temp and then XOR with in3

endmodule
