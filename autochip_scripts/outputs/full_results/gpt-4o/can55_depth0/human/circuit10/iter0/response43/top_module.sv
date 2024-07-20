module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	reg state_reg, q_reg;
	
	assign state = state_reg;
	assign q = q_reg;
	
	always @(posedge clk) begin
		if (a & b) begin
			state_reg <= 1'b0;
			q_reg <= 1'b0;
		end else if (a & ~b) begin
			state_reg <= 1'b1;
			q_reg <= 1'b1;
		end else if (~a & b) begin
			state_reg <= ~state_reg;
			q_reg <= ~state_reg;
		end else begin
			q_reg <= state_reg;
		end
	end
endmodule
