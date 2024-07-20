module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg current_state, next_state;

always @(*) begin
	if (current_state == 1'b0) begin // state A
		if (j) // transition to state B
			next_state = 1'b1;
		else // stay in state A
			next_state = 1'b0;
	end else begin // state B
		if (k) // transition to state A
			next_state = 1'b0;
		else // stay in state B
			next_state = 1'b1;
	end
end

always @(posedge clk or posedge areset) begin
	if (areset)
		current_state <= 1'b0;
	else
		current_state <= next_state;
end

assign out = (current_state == 1'b1) ? 1'b1 : 1'b0;

endmodule
