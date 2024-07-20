module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg current_state, next_state;

always_comb begin
	if (current_state == 0) begin
		if (j == 1) begin
			next_state = 1;
		end else begin
			next_state = 0;
		end
	end else begin
		if (k == 1) begin
			next_state = 0;
		end else begin
			next_state = 1;
		end
	end
end

always@(posedge clk) begin
	if (areset == 1) begin
		current_state <= 0;
	else
		current_state <= next_state;
	end
end

assign out = (current_state == 1) ? 1 : 0;

endmodule
