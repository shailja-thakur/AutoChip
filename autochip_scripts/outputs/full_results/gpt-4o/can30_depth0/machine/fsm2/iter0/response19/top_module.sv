module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// Define state encoding
	typedef enum logic [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01
	} state_t;
	
	// State register
	reg state, next_state;
	
	// Combinational logic to determine next state
	always @(*) begin
		case(state)
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
			default: next_state = STATE_A; // Default state
		endcase
	end
	
	// Sequential logic to update state on clock edge or reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_A; // Reset state to A
		else
			state <= next_state; // Update state
	end
	
	// Output logic
	always @(*) begin
		case(state)
			STATE_A: out = 1'b0;
			STATE_B: out = 1'b1;
			default: out = 1'b0; // Default output state
		endcase
	end
	
endmodule
