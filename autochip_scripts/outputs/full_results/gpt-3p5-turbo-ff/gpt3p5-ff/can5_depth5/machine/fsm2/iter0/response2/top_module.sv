module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b0;
	else begin
		state <= next_state;
	end
end

always @* begin
	if (state == 2'b00) begin
		if (j)
			next_state = 2'b01;
		else
			next_state = 2'b00;
	end

	if (state == 2'b01) begin
		if (k)
			next_state = 2'b00;
		else
			next_state = 2'b01;
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
