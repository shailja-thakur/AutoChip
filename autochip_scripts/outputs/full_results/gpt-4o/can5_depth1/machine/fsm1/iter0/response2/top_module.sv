module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state encoding
	localparam STATE_A = 1'b0;
	localparam STATE_B = 1'b1;
	
	// State register
	reg state, next_state;
	
	// State transition logic (combinational)
	always @(*) begin
		case (state)
			STATE_A: if (in) next_state = STATE_A;
			         else next_state = STATE_B;
			STATE_B: if (in) next_state = STATE_B;
			         else next_state = STATE_A;
			default: next_state = STATE_B; // Default state is B
		endcase
	end
	
	// State update logic (sequential)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B; // Reset state to B
		else
			state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		if (state == STATE_B)
			out = 1'b1;
		else
			out = 1'b0;
	end
	
endmodule
