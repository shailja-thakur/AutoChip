module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
    logic xnor_out;
    
    assign xnor_out = ~(in1 ^ in2); // XNOR operation between in1 and in2
    assign out = xnor_out ^ in3;    // XOR operation with in3 and the result of XNOR operation

endmodule
