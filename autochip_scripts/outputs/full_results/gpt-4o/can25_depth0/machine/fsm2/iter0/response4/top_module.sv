module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State declaration
	typedef enum reg {STATE_A, STATE_B} state_t;
	state_t current_state, next_state;

	// Combinational block to determine next state based on current state and inputs
	always @(*) begin
		case (current_state)
			STATE_A: begin
				if (j)
					next_state = STATE_B;
				else
					next_state = STATE_A;
			end
			
			STATE_B: begin
				if (k)
					next_state = STATE_A;
				else
					next_state = STATE_B;
			end

			default: next_state = STATE_A; // Default state should not occur, but good practice to add
		endcase
	end

	// Clocked block to update current state and output based on areset and next state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= STATE_A;
        end else begin
			current_state <= next_state;
		end
	end

	// Output logic
	always @(*) begin
		case (current_state)
			STATE_A: out = 0;
			STATE_B: out = 1;
			default: out = 0;
		endcase
	end

endmodule
