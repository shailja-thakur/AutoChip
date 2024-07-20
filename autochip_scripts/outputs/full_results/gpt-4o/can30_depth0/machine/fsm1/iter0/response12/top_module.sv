module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg state, next_state;
	
	parameter STATE_A = 0, STATE_B = 1;
	
	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: next_state = (in) ? STATE_A : STATE_B;
			STATE_B: next_state = (in) ? STATE_B : STATE_A;
			default: next_state = STATE_B;
		endcase
	end
	
	// State update logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end
	
	// Output logic
	assign out = (state == STATE_B);
endmodule
