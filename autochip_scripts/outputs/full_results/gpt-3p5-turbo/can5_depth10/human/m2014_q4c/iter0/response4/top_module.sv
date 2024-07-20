module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	
    // Creating a temporary variable to hold the intermediate value of q
	logic temp_q;
	
    // D flip flop implementation
	always_ff @(posedge clk, posedge r)
	begin
		if (r)
			temp_q <= 1'b0;
		else
			temp_q <= d;
	end
	
	// Assigning the temporary variable value to output q
	assign q = temp_q;
	
endmodule
