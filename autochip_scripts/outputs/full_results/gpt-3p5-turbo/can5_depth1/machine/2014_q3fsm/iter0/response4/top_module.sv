module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define states
	typedef enum logic[3:0] {
		state_A,
		state_B,
		state_C,
		state_S10,
		state_S11,
		state_S20,
		state_S21,
		state_S22
	} state_type;

	// Define current and next state variables
	reg[state_type] current_state;
	reg[state_type] next_state;

	// Initialize state variables
	initial begin
		current_state = state_B;
		next_state = state_B;
	end

	// Create state transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= state_B;
		end else begin
			current_state <= next_state;
		end
	end

	// Define state transition conditions
	always_comb begin
		case (current_state)
			state_B:
				if (w) begin
					next_state = state_S11;
				end else begin
				    next_state = state_S10;
				end
			state_C:
				if (w) begin
					next_state = state_S11;
				end else begin
				    next_state = state_S10;
				end
			state_S10:
				if (w) begin
					next_state = state_S21;
				end else begin
				    next_state = state_S20;
				end
			state_S11:
				if (w) begin
					next_state = state_S22;
				end else begin
				    next_state = state_S21;
				end
			state_S20:
				next_state = state_B;
			state_S21:
				if (w) begin
					next_state = state_C;
				end else begin
				    next_state = state_B;
				end
			state_S22:
				if (w) begin
					next_state = state_B;
				end else begin
				    next_state = state_C;
				end
			default:
				next_state = state_B;
		endcase
	end

	// Update output based on current state
	always @(posedge clk) begin
		case (current_state)
			state_B:
				z <= 0;
			state_C:
				z <= 1;
			state_S10:
				z <= 0;
			state_S11:
				z <= 1;
			state_S20:
				z <= 0;
			state_S21:
				z <= 1;
			state_S22:
				z <= 1;
			default:
				z <= 0;
		endcase
	end

endmodule
