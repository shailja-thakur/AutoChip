module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
    // Intermediate wire to hold the result of in1 XOR in2
    wire temp;
    
    // Perform the bitwise XOR on in1 and in2
    assign temp = in1 ^ in2;
    
    // Perform the bitwise NOT operation on the result
    // and then XOR with in3
    assign out = ~temp ^ in3;

endmodule
