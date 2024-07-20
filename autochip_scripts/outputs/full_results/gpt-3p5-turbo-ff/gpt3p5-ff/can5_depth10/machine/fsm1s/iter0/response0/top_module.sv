module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 1'b0;
parameter B = 1'b1;

reg state, next_state;

always @(posedge clk) begin
	if (reset) begin
		state <= B;
	end
	else begin
		state <= next_state;
	end
end

always @* begin
	if (state == A) begin
		if (in) begin
			next_state = A;
		end
		else begin
			next_state = B;
		end
	end
	else begin
		if (in) begin
			next_state = B;
		end
		else begin
			next_state = A;
		end
	end
end

assign out = state;

endmodule
