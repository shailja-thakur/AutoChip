module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q_next, state_next;
reg q_reg, state_reg;

always @(posedge clk) begin
	state_reg <= state_next;
	q_reg <= q_next;
end

always @(*) begin
	q_next = (a & ~b) | (~a & b);
	state_next = (a & b);
end

assign q = q_reg;
assign state = state_reg;

endmodule
