module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;
reg [1:0] next_state;

always @(*) begin
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

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= next_state;

	if (state == 2'b01)
		out <= 1'b1;
	else
		out <= 1'b0;
end

endmodule
