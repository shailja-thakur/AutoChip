module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	enum logic [1:0] {A, B, C, D} state, next_state;

	// Define outputs
	logic out_reg;

	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	always_comb
	begin
		case (state)
			A:
				begin
					if (in)
						next_state = B;
					else
						next_state = A;
				end
			B:
				begin
					if (in)
						next_state = B;
					else
						next_state = C;
				end
			C:
				begin
					if (in)
						next_state = D;
					else
						next_state = A;
				end
			D:
				begin
					if (in)
						next_state = B;
					else
						next_state = C;
				end
		endcase
	end

	always_comb
	begin
		if (state == D)
			out_reg = 1'b1;
		else
			out_reg = 1'b0;
	end

	assign out = out_reg;

endmodule
