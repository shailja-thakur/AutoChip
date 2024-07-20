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
	if (state_reg) begin
		q_reg <= a & b;
	end else begin
		q_reg <= 1'b0;
	end

	state_reg <= (a & ~b & ~state_reg) | (~a & b & state_reg);
end

assign q = q_reg;
assign state = state_reg;

endmodule
