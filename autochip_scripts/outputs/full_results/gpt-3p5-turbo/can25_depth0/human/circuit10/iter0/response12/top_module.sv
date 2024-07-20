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
	if (state == 0 && a == 0 && b == 0)
		q <= 0;
	else if (state == 0 && a == 0 && b == 1)
		q <= 1;
	else if (state == 0 && a == 1 && b == 0)
		q <= 1;
	else if (state == 0 && a == 1 && b == 1)
		q <= 0;
	else if (state == 1 && a == 0 && b == 0)
		q <= 1;
	else if (state == 1 && a == 0 && b == 1)
		q <= 0;
	else if (state == 1 && a == 1 && b == 0)
		q <= 0;
	else if (state == 1 && a == 1 && b == 1)
		q <= 1;
	end
	
	if (clk == 1)
		state <= q;
end
endmodule
