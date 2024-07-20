module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states
	typedef enum logic [1:0] {A, B, C, D} state_type;

	// Define the state and next_state variables
	reg state_type state;
	reg state_type next_state;

	// Define the outputs
	reg out;

	// Define the state transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Define the state transition logic
	always_comb begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end

			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end

			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
			end

			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
		endcase
	end

	// Define the output logic
	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
