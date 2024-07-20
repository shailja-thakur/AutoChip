module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	parameter B = 1'b0;
	parameter A = 1'b1;
	reg state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	always @(state, in) begin
		case (state)
			B: begin
				out <= 1'b0;
				if (in)
					next_state <= B;
				else
					next_state <= A;
			end
			A: begin
				out <= 1'b1;
				if (in)
					next_state <= A;
				else
					next_state <= B;
			end
		endcase
	end
endmodule
