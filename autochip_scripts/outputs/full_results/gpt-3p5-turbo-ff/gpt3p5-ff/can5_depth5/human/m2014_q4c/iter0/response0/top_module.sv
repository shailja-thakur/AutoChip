module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	
	logic q_ff;

	always_ff @(posedge clk) begin
		if (r == 1'b1) // Active high reset
			q_ff <= 1'b0;
		else
			q_ff <= d;
	end

	assign q = q_ff;
	
endmodule
