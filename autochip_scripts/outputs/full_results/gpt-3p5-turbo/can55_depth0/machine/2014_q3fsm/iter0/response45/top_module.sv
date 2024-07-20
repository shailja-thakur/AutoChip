module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

	// Define states
	typedef enum logic [3:0] {
		A, B, C, S10, S11, S20, S21, S22
	} state_type;

	// Declare state variable
	reg [3:0] current_state, next_state;

	// Initialize state variables
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	// Assign next state based on current state and input signals
	always @* begin
		case (current_state)
			A: begin
				if (s) begin
					next_state = B;
				end else begin
					next_state = current_state;
				end
			end
			B: begin
				if (w) begin
					next_state = S11;
				end else begin
					next_state = S10;
				end
			end
			C: begin
				if (w) begin
					next_state = S11;
				end else begin
					next_state = S10;
				end
			end
			S10: begin
				if (w) begin
					next_state = S21;
				end else begin
					next_state = S20;
				end
			end
			S11: begin
				if (w) begin
					next_state = S22;
				end else begin
					next_state = S21;
				end
			end
			S20: begin
				next_state = B;
			end
			S21: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = B;
				end
			end
			S22: begin
				if (w) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			default: next_state = current_state;
		endcase
	end

	// Update current state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	// Output logic
	always @* begin
		case (current_state)
			B: z = 1'b0;
			C: z = 1'b0;
			default: z = 1'b1;
		endcase
	end

endmodule
