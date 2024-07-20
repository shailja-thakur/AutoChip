module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg [1:0] state;
reg [1:0] nextState;

always @(*) begin
	if (state == 2'b00) begin
		if (j)
			nextState = 2'b10;
		else
			nextState = 2'b00;
	end else begin
		if (k)
			nextState = 2'b00;
		else
			nextState = 2'b10;
	end
end

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else
		state <= nextState;
end

assign out = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
