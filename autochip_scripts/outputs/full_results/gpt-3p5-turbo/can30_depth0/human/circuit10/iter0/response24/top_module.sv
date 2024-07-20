module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

	reg q_reg;
	reg state_reg;

	always @(posedge clk) begin
		if (state_reg == 1'b0 && a == 1'b0 && b == 1'b0)
			q_reg <= 1'b0;
		else if (state_reg == 1'b0 && a == 1'b0 && b == 1'b1)
			q_reg <= 1'b1;
		else if (state_reg == 1'b0 && a == 1'b1 && b == 1'b0)
			q_reg <= 1'b1;
		else if (state_reg == 1'b0 && a == 1'b1 && b == 1'b1)
			q_reg <= 1'b0;
		else if (state_reg == 1'b1 && a == 1'b0 && b == 1'b0)
			q_reg <= 1'b1;
		else if (state_reg == 1'b1 && a == 1'b0 && b == 1'b1)
			q_reg <= 1'b0;
		else if (state_reg == 1'b1 && a == 1'b1 && b == 1'b0)
			q_reg <= 1'b0;
		else if (state_reg == 1'b1 && a == 1'b1 && b == 1'b1)
			q_reg <= 1'b1;
		end
	end

	always @(posedge clk) begin
		if (state_reg == 1'b0 && a == 1'b0 && b == 1'b0)
			state_reg <= 1'b0;
		else if (state_reg == 1'b0 && a == 1'b0 && b == 1'b1)
			state_reg <= 1'b1;
		else if (state_reg == 1'b0 && a == 1'b1 && b == 1'b0)
			state_reg <= 1'b0;
		else if (state_reg == 1'b0 && a == 1'b1 && b == 1'b1)
			state_reg <= 1'b0;
		else if (state_reg == 1'b1 && a == 1'b0 && b == 1'b0)
			state_reg <= 1'b0;
		else if (state_reg == 1'b1 && a == 1'b0 && b == 1'b1)
			state_reg <= 1'b1;
		else if (state_reg == 1'b1 && a == 1'b1 && b == 1'b0)
			state_reg <= 1'b1;
		else if (state_reg == 1'b1 && a == 1'b1 && b == 1'b1)
			state_reg <= 1'b0;
		end
	end

	assign q = q_reg;
	assign state = state_reg;

endmodule
