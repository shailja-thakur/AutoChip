module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	reg state, next_state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	always @(state, j, k) begin
		case (state)
			A: begin
				if (j)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (k)
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end

	assign out = (state == B) ? 1'b1 : 1'b0;
endmodule
