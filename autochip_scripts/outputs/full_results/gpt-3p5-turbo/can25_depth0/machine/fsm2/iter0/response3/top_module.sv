module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg state, next_state;

always @(*) begin
	if (state == 1'b0) begin
		if (j) begin
			next_state = 1'b1;
		end
		else begin
			next_state = 1'b0;
		end
	end
	else begin
		if (k) begin
			next_state = 1'b0;
		end
		else begin
			next_state = 1'b1;
		end
	end
end

always @(posedge clk) begin
	if (areset) begin
		state <= 1'b0;
	end
	else begin
		state <= next_state;
	end
end

assign out = state;

endmodule
