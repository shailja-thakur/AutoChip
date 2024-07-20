module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {
		A,
		B
	} state_t;

	reg state, next_state;

	// State register
	always_ff @(posedge clk, posedge areset)
	begin
		if (areset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Determine next state based on current state and input
	always_comb
	begin
		case (state)
			A: begin
				if (in) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end

			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
		endcase
	end

	// Output logic
	assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
