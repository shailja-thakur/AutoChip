module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg state, next_state;

always @*
begin
	if (state == 0)
		begin
			if (j)
				next_state = 1;
			else
				next_state = 0;
		end
	else
		begin
			if (k)
				next_state = 0;
			else
				next_state = 1;
		end
end

always @(posedge clk or posedge areset)
begin
	if (areset)
		state <= 0;
	else
		state <= next_state;
end

assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
