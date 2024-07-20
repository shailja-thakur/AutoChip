module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State Definitions
	typedef enum logic [1:0] {
		S_INIT,  // Initial State
		S_PASS_X, // Passing bits x
		S_COMPLEMENT, // Complement bits
		S_DONE    // Done processing
	} state_t;
	
	state_t state, next_state;
	reg complement;
	reg first_one_detected;

	// State Transition
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_INIT;
		end else begin
			state <= next_state;
		end
	end

	// Next State Logic
	always_comb begin
		case (state)
			S_INIT: begin
				next_state = S_PASS_X;
			end
			S_PASS_X: begin
				if (first_one_detected) begin
					next_state = S_COMPLEMENT;
				end else begin
					next_state = S_PASS_X;
				end
			end
			S_COMPLEMENT: begin
				if (areset) begin
					next_state = S_DONE;
				end else if (x) begin
					next_state = S_COMPLEMENT;
				end else begin
					next_state = S_COMPLEMENT;
				end
			end
			S_DONE: begin
				next_state = S_DONE;
			end
			default: next_state = S_INIT;
		endcase
	end

	// Output Logic & Internal Signals
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			z <= 0;
			complement <= 0;
			first_one_detected <= 0;
		end else begin
			case (state)
				S_INIT: begin
					z <= 0;
					complement <= 0;
					first_one_detected <= 0;
				end
				S_PASS_X: begin
					if (x == 1'b1) begin
						first_one_detected <= 1;
						z <= 1'b1; // The bit is 1 and we should pass it as it is the 1 in 2's compliment
					end else begin
						z <= x; // Pass the bits as they are until we encounter the first 1
					end
				end
				S_COMPLEMENT: begin
					z <= ~x;
				end
				S_DONE: begin
					// Maintain last state
				end
				default: begin
					z <= 0;
				end
			endcase
		end
	end

endmodule
