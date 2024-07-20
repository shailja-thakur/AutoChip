module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// State declarations
	typedef enum logic [0:0] {
		A = 1'b0,
		B = 1'b1
	} state_t;

	state_t state, next_state;

	// Output logic
	assign out = (state == B);

	// State transition logic for the next state
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;  // Initialize state to A on reset
		end else begin
			state <= next_state;  // Update state to the next state on clock edge
		end
	end

	// Next state logic
	always_comb begin
		case (state)
			A: begin
				if (j) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (k) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			default: begin
				next_state = A;  // Default to state A
			end
		endcase
	end

endmodule
