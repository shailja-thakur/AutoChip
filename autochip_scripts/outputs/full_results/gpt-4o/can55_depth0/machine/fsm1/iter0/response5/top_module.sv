module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

// States definition
typedef enum logic [1:0] {
	STATE_A = 2'b00,
	STATE_B = 2'b01
} state_t;

// State registers
state_t current_state, next_state;

// State transition logic
always @(*) begin
	case (current_state)
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

// State register update
always @(posedge clk or posedge areset) begin
	if (areset)
		current_state <= STATE_B;
	else
		current_state <= next_state;
end

// Output logic
always @(posedge clk or posedge areset) begin
	if (areset)
		out <= 1'b1; // State B, so out = 1
	else
		out <= (current_state == STATE_B) ? 1'b1 : 1'b0;
end

endmodule
