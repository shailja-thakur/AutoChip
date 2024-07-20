module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg [1:0] {STATE_B = 2'b00, STATE_A = 2'b01} state_t;
	state_t current_state, next_state;

	// Synchronous state transition
	always @(posedge clk) begin
		if (reset) begin
			current_state <= STATE_B;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			STATE_B: begin
				if (in) begin
					next_state = STATE_B;
				end else begin
					next_state = STATE_A;
				end
			end

			STATE_A: begin
				if (in) begin
					next_state = STATE_A;
				end else begin
					next_state = STATE_B;
				end
			end

			default: begin
				next_state = STATE_B; // default state
			end
		endcase
	end

	// Output logic
	always @(*) begin
		case (current_state)
			STATE_B: out = 1;
			STATE_A: out = 0;
			default: out = 1; // default output
		endcase
	end

endmodule
