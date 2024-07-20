module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	
	always @(posedge clk)
		if (r)
			q <= 0;
		else
			q <= d;
			
endmodule
