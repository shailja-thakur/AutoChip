module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	
	logic q_ff;
	
	always_ff @(posedge clk or posedge r) begin
		if (r)
			q_ff <= 0;
		else if (clk)
			q_ff <= d;
	end
	
	assign q = q_ff;
	
endmodule
