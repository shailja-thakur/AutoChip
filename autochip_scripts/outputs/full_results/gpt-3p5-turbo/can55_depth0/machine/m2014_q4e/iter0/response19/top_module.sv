module top_module (
	input in1,
	input in2,
	output logic out
);
  
	// Logical OR of input signals
	logic or_output;
  
	// Logical NOT of logical OR output
	assign out = ~or_output;
  
	// Implementing logical OR gate
	always_comb begin
		or_output = in1 | in2;
	end
endmodule
