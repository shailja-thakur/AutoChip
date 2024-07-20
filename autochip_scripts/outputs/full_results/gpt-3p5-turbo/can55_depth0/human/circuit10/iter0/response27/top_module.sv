module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);
	reg q_reg;

	always @(posedge clk) begin
		if (a & !b)
			q_reg <= 1'b1;
		else if (!a & b)
			q_reg <= 1'b0;
		end
	end

	assign q = q_reg;
	assign state = q_reg;
endmodule
