module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg q_next;
reg state_next;

always @(posedge clk) begin
	state <= state_next;
	q <= q_next;
end

always @* begin
	if (a & ~b)
		state_next = 1'b1;
	else
		state_next = 1'b0;

	q_next = state_next;
end

endmodule
