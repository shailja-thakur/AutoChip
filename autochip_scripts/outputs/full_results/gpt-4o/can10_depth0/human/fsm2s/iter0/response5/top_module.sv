module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg {OFF, ON} state_t;
	state_t state, next_state;

	// State transition logic
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
				if (j == 1)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				if (k == 1)
					next_state = OFF;
				else
					next_state = ON;
			end
			default: next_state = OFF;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			out <= 0;
		end else begin
			case (state)
				OFF: out <= 0;
				ON:  out <= 1;
				default: out <= 0;
			endcase
		end
	end

endmodule
