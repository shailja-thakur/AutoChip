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
	state <= a & b;
	if (state == 2'b00)
		q <= 1'b0;
	else if (state == 2'b01)
		q <= 1'b1;
	else if (state == 2'b10)
		q <= 1'b1;
	else
		q <= q;
end

endmodule
