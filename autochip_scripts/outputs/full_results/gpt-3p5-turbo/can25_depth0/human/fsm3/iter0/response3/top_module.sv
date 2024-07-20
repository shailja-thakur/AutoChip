module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg state, next_state;
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	always @(state, in)
	begin
		case (state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 0;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out = 0;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out = 0;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out = 1;
			end
		endcase
	end
endmodule
