module top_module (
	input wire clk,
	input wire j,
	input wire k,
	input wire areset,
	output wire out
);

reg state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 1'b0;
	else
		state <= next_state;
end

always @(*) begin
	if (state == 1'b0) begin
		if (j)
			next_state = 1'b1;
		else
			next_state = 1'b0;
	end else begin
		if (k)
			next_state = 1'b0;
		else
			next_state = 1'b1;
	end
end

assign out = state;

endmodule
