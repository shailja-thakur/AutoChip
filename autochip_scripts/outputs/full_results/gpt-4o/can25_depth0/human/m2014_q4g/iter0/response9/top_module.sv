module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
    
    logic xnor_out;
    
    // XNOR operation
    assign xnor_out = ~(in1 ^ in2);
    
    // XOR operation
    assign out = xnor_out ^ in3;
    
endmodule
