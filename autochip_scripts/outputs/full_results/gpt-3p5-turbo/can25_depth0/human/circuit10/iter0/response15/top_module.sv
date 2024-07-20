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
		if (state) begin
			q <= b;
			state <= a & !b;
		end else begin
			q <= 0;
			state <= a;
		end
	end

endmodule
