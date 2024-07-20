module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg state, next_state;

	parameter B = 0;
	parameter A = 1;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= B;
		else
			state <= next_state;
	end

	always @* begin
		case (state)
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end

	always @(state) begin
		if (state == B)
			out = 1;
		else
			out = 0;
	end

endmodule
