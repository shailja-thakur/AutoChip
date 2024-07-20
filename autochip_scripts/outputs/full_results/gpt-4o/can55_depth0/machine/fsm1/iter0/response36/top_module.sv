module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State encoding
	typedef enum reg [0:0] {STATE_A = 1'b0, STATE_B = 1'b1} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (in) next_state = STATE_A;
				else next_state = STATE_B;
			end
			STATE_B: begin
				if (in) next_state = STATE_B;
				else next_state = STATE_A;
			end
			default: next_state = STATE_B; // Default case to handle unexpected situations
		endcase
	end

	// State update on clock's rising edge or reset
	always @(posedge clk or posedge areset) begin
		if (areset) state <= STATE_B;
		else state <= next_state;
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset) out <= 1'b1;
		else out <= (state == STATE_B);
	end

endmodule
