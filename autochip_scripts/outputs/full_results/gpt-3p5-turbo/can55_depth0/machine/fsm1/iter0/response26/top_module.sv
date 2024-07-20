module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 0;
	else
		state <= next_state;
end

always @(state, in) begin
	if (state == 0) begin
		if (in)
			next_state = 0;
		else
			next_state = 1;
	end else begin
		if (in)
			next_state = 1;
		else
			next_state = 0;
	end
end

assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
