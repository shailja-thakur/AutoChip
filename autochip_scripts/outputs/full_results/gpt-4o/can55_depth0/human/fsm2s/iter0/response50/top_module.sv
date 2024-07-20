module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
	// State definitions
	typedef enum reg {OFF, ON} state_t;
	state_t state, next_state;

	// State transition
	always @(posedge clk) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			OFF: begin
				if (j) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
			ON: begin
				if (k) begin
					next_state = OFF;
				end else begin
					next_state = ON;
				end
			end
			default: next_state = OFF;  // Default to OFF as a safety
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			out <= 0;
		end else begin
			case (state)
				OFF: out <= 0;
				ON: out <= 1;
				default: out <= 0;  // Default to 0 as a safety
			endcase
		end
	end
endmodule
