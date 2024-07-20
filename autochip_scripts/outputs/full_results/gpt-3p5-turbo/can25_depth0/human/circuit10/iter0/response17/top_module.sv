module top_module (
	input clk,
	input a,
	input b,
	output q,
	output state
);

reg q;
reg state;

always @(posedge clk) begin
	if (state == 1) begin
		if (a == 1'b1 && b == 1'b1)
			state <= 1'b1;
		else
			state <= 1'b0;
	end else begin
		if (a == 1'b1 && b == 1'b0)
			state <= 1'b1;
		else
			state <= 1'b0;
	end

	if (state == 1'b1)
		q <= 1'b1;
	else
		q <= 1'b0;
end

endmodule
