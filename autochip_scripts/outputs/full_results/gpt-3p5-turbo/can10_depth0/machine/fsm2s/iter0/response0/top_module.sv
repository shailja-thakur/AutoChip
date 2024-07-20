module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
wire next_state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
	else if (state == 2'b0) begin
		if (j)
			state <= 2'b1;
		else
			state <= 2'b0;
	end else if (state == 2'b1) begin
		if (k)
			state <= 2'b0;
		else
			state <= 2'b1;
	end
end

assign next_state = state;

assign out = (state == 2'b1) ? 1'b1 : 1'b0;

endmodule
