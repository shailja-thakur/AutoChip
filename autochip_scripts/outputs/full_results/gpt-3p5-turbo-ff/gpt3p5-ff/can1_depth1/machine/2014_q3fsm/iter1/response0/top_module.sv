module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

	// Define states
	typedef enum logic [3:0] {
		A,
		B,
		C,
		S10,
		S11,
		S20,
		S21,
		S22
	} state_type;

	// Declare and initialize state variable
	reg state_type current_state;
	reg state_type next_state;

	initial begin
		current_state = A;    // Set initial state
	end

	// Always block for state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
            current_state <= A;    // Reset state to A
        end else begin
            current_state <= next_state;
        end
	end
	
	// Assign next_state based on current_state and inputs
	always @* begin
		case (current_state)
			A: begin
				if (s) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B, C: begin
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
			default: next_state = A; // Default value for undefined states
		endcase
	end
	
	// Always block for output z
	always @(posedge clk) begin
		if (reset) begin
			z <= 0;
		end else begin
			case (current_state)
				B, S11, S20: begin
					z <= 1;
				end
				default: begin
					z <= 0;
				end
			endcase
		end
	end

endmodule
