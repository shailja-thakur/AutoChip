module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg state;
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 1'b0;
	else begin
		if (state == 1'b0)
			state <= (in) ? 1'b0 : 1'b1;
		else
			state <= (in) ? 1'b1 : 1'b0;
	end
end

assign out = (state == 1'b1) ? 1'b1 : 1'b0;

endmodule
