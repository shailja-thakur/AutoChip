module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// State transition and output logic
	always @* begin
		case (state)
			B: begin
				if (in) begin
					next_state = B;
					out = 1;
				end else begin
					next_state = A;
					out = 1;
				end
			end
			A: begin
				if (in) begin
					next_state = A;
					out = 0;
				end else begin
					next_state = B;
					out = 0;
				end
			end
			default: begin
				next_state = B; // default state
			end
		endcase
	end

	// Sequential block for state update
	always @(posedge clk) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
		out <= (state == B) ? 1 : 0; // Moore output
		end
endmodule
