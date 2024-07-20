module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg next_state;

always @(posedge clk) begin
	if (reset)
		state <= 2'b00;
	else
		state <= next_state;
end

always @(state, j, k) begin
	if (state == 2'b00) begin
		if (j)
			next_state = 2'b01;
		else
			next_state = 2'b00;
	end else if (state == 2'b01) begin
		if (k)
			next_state = 2'b00;
		else
			next_state = 2'b01;
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
