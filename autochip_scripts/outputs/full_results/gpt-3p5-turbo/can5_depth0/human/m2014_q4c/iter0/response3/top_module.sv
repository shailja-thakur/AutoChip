module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
	
	logic q_reg;
	
	always_ff @(posedge clk or posedge r) begin
		if (r) begin
			q_reg <= 0;
		end else begin
			q_reg <= d;
		end
	end
	
	assign q = q_reg;
	
endmodule
