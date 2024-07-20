module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define the states
	typedef enum logic [2:0] {
		A,
		B,
		C,
		D,
		E,
		F
	} state_t;

	// Define the current and next state variables
	reg state_t current_state;
	reg state_t next_state;

	// Define the output signal
	wire z;

	// Define the state transition and output logic
	always @(posedge clk or posedge reset) begin
		// Check for reset
		if (reset) begin
			current_state <= A;
		end
		else begin
			current_state <= next_state;
		end

		// Determine the next state based on the current state and input w
		case (current_state)
			A: begin
				if (w) begin
					next_state <= A;
				end
				else begin
					next_state <= B;
				end
			end
			B: begin
				if (w) begin
					next_state <= D;
				end
				else begin
					next_state <= C;
				end
			end
			C: begin
				if (w) begin
					next_state <= D;
				end
				else begin
					next_state <= E;
				end
			end
			D: begin
				if (w) begin
					next_state <= A;
				end
				else begin
					next_state <= F;
				end
			end
			E: begin
				if (w) begin
					next_state <= D;
				end
				else begin
					next_state <= E;
				end
			end
			F: begin
				if (w) begin
					next_state <= D;
				end
				else begin
					next_state <= C;
				end
			end
			default: begin
				next_state <= A;
			end
		endcase
	end

	// Assign the output signal z based on the current state
	assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;

endmodule
