module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;

	reg state, next_state;

	always_ff @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always_comb begin
		case (state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out <= 0;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out <= 0;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out <= 0;
			end
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out <= 1;
			end
		endcase
	end

endmodule
