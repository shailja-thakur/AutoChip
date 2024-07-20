module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: next_state = in ? STATE_A : STATE_B;
			STATE_B: next_state = in ? STATE_B : STATE_A;
			default: next_state = STATE_B; // Default to STATE_B to handle incorrect states
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
	always @(*) begin
		out = (state == STATE_B);
	end
endmodule
