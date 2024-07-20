module top_module (
	input clk,
	input d,
	input r,
	output logic q
);

	always_ff @(posedge clk) begin
		if (r) // active high reset
			q <= 0; // reset output to 0
		else
			q <= d; // update output with input
	end
	
endmodule
