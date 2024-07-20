module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define states
	typedef enum logic [2:0] {
		A,
		B,
		C,
		D,
		E,
		F
	} state_t;

	// Define state variable and next state variable
	state_t state, next_state;

	// Output assignment
	assign z = (state == E || state == F) ? 1'b1 : 1'b0;

	// State machine process
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A; // Reset to initial state A
		end else begin
			state <= next_state; // Transition to next state
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			A: begin
				if (w == 1'b0) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (w == 1'b1) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			C: begin
				if (w == 1'b1) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			D: begin
				if (w == 1'b1) begin
					next_state = A;
				end else begin
					next_state = F;
				end
			end
			E: begin
				if (w == 1'b1) begin
					next_state = D;
				end else begin
					next_state = E;
				end
			end
			F: begin
				if (w == 1'b1) begin
					next_state = D;
				end else begin
					next_state = C;
				end
			end
			default: next_state = A;
		endcase
	end

endmodule
