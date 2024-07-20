module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	typedef enum logic [1:0] {STATE_A = 2'b00, STATE_B = 2'b01} state_t;
	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= STATE_B; // Reset to state B
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always_comb begin
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
			default: next_state = STATE_B;
		endcase
	end

	// Output logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			out <= 1'b1;
		end else begin
			if (state == STATE_B)
				out <= 1'b1;
			else
				out <= 1'b0;
		end
	end
	
endmodule
