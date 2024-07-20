module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// parameter definitions
	parameter STATE_A = 1;
	parameter STATE_B = 0;

	// state register
	reg state;

	always @(posedge clk) begin
		if (reset)
			state <= STATE_B;
		else begin
			if (state == STATE_A)
				state <= (in ? STATE_A : STATE_B);
			else if (state == STATE_B)
				state <= (in ? STATE_B : STATE_A);
		end
	end

	assign out = (state == STATE_B) ? 1'b1 : 1'b0;

endmodule
