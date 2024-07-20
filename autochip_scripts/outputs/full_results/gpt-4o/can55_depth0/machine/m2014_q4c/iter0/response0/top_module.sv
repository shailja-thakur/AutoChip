module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	always_ff @(posedge clk or posedge r) begin
		if (r)
			q <= 1'b0;    // Reset the register output to 0 when reset is active
		else
			q <= d;      // Store the data input into the register
	end
endmodule
