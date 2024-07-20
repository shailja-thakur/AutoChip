module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg {
		STATE_A = 1'b0,
		STATE_B = 1'b1
	} state_t;

	// State registers
	reg state, next_state;

	// Asynchronous reset logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (in)
					next_state = STATE_A;
				else
					next_state = STATE_B;
			end
			STATE_B: begin
				if (in)
					next_state = STATE_B;
				else
					next_state = STATE_A;
			end
			default: next_state = STATE_B; // Default to B on unexpected state
		endcase
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			out <= 1'b1; // output corresponding to state B on reset
		else begin
			case (state)
				STATE_A: out <= 1'b0;
				STATE_B: out <= 1'b1;
			endcase
		end
	end
endmodule
