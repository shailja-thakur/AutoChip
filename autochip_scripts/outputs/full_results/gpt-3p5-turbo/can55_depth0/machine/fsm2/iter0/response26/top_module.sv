module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

reg [1:0] state, next_state;

always @(state, j, k) begin
	if (state == 2'b00) begin
		if (j) begin
			next_state = 2'b01;
		end else begin
			next_state = 2'b00;
		end
	end else if (state == 2'b01) begin
		if (k) begin
			next_state = 2'b00;
		end else begin
			next_state = 2'b01;
		end
	end
end

always @(posedge clk) begin
	if (areset) begin
		state <= 2'b00;
	else
		state <= next_state;
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
