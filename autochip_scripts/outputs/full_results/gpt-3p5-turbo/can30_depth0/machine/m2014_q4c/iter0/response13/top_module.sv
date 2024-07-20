module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	
	always @(posedge clk) begin
		if (r) // reset is active
			q <= 0;
		else
			q <= d;
	end
	
endmodule
