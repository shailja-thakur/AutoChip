module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// Define state encoding
	typedef enum logic [1:0] {
		OFF = 2'b00,
		ON = 2'b01
	} state_t;

	// State registers
	state_t state, next_state;

	// State transition logic (next state logic)
	always @(*) begin
		case (state)
			OFF: begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
			default: next_state = OFF;
		endcase
	end

	// Synchronous state updates and output logic
	always @(posedge clk) begin
		if (reset) begin
			state <= OFF;
			out <= 1'b0;
		end else begin
			state <= next_state;
			case (next_state)
				OFF: out <= 1'b0;
				ON: out <= 1'b1;
			endcase
		end
	end

endmodule
