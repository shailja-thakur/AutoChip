module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);


reg current_state, next_state;

always_comb begin
	if (current_state == 1'b0) begin
		if (j) begin
			next_state = 1'b1;
		end else begin
			next_state = 1'b0;
		end
	end else begin
		if (k) begin
			next_state = 1'b0;
		end else begin
			next_state = 1'b1;
		end
	end
end

always @(posedge clk or posedge areset) begin
	if (areset) begin
		current_state <= 1'b0;
	else begin
		current_state <= next_state;
	end
end

assign out = current_state;

endmodule
