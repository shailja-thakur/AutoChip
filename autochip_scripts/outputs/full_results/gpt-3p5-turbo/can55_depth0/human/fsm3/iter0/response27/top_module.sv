module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states
	enum {A, B, C, D} state, next_state;

	// Define the outputs
	reg out_reg;

	// Define the transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			// Asynchronous reset
			state <= A;
		end else begin
			// Synchronous state transition
			state <= next_state;
		end
	end

	always @* begin
		case (state)
			A:
				begin
					if (in)
						next_state = B;
					else
						next_state = A;
					out_reg = 0;
				end
			B:
				begin
					if (in)
						next_state = B;
					else
						next_state = C;
					out_reg = 0;
				end
			C:
				begin
					if (in)
						next_state = D;
					else
						next_state = A;
					out_reg = 0;
				end
			D:
				begin
					if (in)
						next_state = B;
					else
						next_state = C;
					out_reg = 1;
				end
		endcase
	end

	// Assign the output
	assign out = out_reg;

endmodule
