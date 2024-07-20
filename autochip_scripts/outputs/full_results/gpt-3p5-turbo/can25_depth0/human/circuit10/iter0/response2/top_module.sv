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
		state <= (a & ~b) | (~a & b);
		if (state == 1'b1)
			q <= 1'b1;
		else
			q <= 1'b0;
	end

endmodule
