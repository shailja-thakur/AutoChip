module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define states
	typedef enum logic [1:0] {
		A,
		B,
		C,
		D
	} state_t;

	reg state_t current_state;
	parameter state_t INITIAL_STATE = A;

	// Next state logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= INITIAL_STATE;
		end else begin
			case (current_state)
				A: begin
					if (in) begin
						current_state <= B;
					end else begin
						current_state <= A;
					end
				end

				B: begin
					if (in) begin
						current_state <= B;
					end else begin
						current_state <= C;
					end
				end

				C: begin
					if (in) begin
						current_state <= D;
					end else begin
						current_state <= A;
					end
				end

				D: begin
					if (in) begin
						current_state <= B;
					end else begin
						current_state <= C;
					end
				end

				default: current_state <= INITIAL_STATE;
			endcase
		end
	end

	// Output logic
	assign out = (current_state == D);

endmodule
