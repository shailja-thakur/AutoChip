module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01,
		STATE_C = 2'b10,
		STATE_D = 2'b11
	} state_t;

	state_t current_state, next_state;

	// State transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= STATE_A;
		end else begin
			current_state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			STATE_A: begin
				if (in) next_state = STATE_B;
				else next_state = STATE_A;
			end
			STATE_B: begin
				if (in) next_state = STATE_B;
				else next_state = STATE_C;
			end
			STATE_C: begin
				if (in) next_state = STATE_D;
				else next_state = STATE_A;
			end
			STATE_D: begin
				if (in) next_state = STATE_B;
				else next_state = STATE_C;
			end
			default: next_state = STATE_A; // Default to state A in case of undefined state
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 1'b0;
		end else begin
			if (current_state == STATE_D) out <= 1'b1;
			else out <= 1'b0;
		end
	end

endmodule
