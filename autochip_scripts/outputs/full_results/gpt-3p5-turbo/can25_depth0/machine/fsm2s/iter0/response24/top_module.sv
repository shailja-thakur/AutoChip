module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg state;
wire next_state;

always @(posedge clk) begin
	if (reset)
		state <= 0;
	else
		state <= next_state;
end

always @(state, j, k) begin
	if (state) begin
		if (j)
			next_state <= 0;
		else
			next_state <= 1;
	end else begin
		if (k)
			next_state <= 1;
		else
			next_state <= 0;
	end
end

assign out = state;

endmodule
