module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

reg state, next_state;

always_comb begin
	if (state == 1'b0) begin
		next_state = j ? 1'b1 : 1'b0;
	end else begin
		next_state = k ? 1'b0 : 1'b1;
	end
end

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 1'b0;
	end else begin
		state <= next_state;
	end
end

assign out = state;

endmodule
