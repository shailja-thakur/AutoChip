module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
    // Intermediate signal to hold the result of in1 XOR in2
    logic intermediate;
    
    // Perform XOR operation on in1 and in2
    assign intermediate = in1 ^ in2;
    
    // Perform NOT operation on the intermediate result and then XOR it with in3 to get the output
    assign out = (~intermediate) ^ in3;

endmodule
