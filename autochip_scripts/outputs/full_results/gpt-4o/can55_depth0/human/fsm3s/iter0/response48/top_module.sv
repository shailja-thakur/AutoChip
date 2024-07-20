module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State enumeration
	typedef enum reg [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01,
		STATE_C = 2'b10,
		STATE_D = 2'b11
	} state_t;

	// State registers
	state_t state, next_state;

	// State transition and output logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (in) 
					next_state = STATE_B;
				else 
					next_state = STATE_A;
				out = 0;
			end
			STATE_B: begin
				if (in) 
					next_state = STATE_B;
				else 
					next_state = STATE_C;
				out = 0;
			end
			STATE_C: begin
				if (in) 
					next_state = STATE_D;
				else 
					next_state = STATE_A;
				out = 0;
			end
			STATE_D: begin
				if (in) 
					next_state = STATE_B;
				else 
					next_state = STATE_C;
				out = 1;
			end
			default: begin
				next_state = STATE_A;
				out = 0;
			end
		endcase
	endmodule
