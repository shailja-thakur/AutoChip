module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State Encoding
	typedef enum reg [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01,
		STATE_C = 2'b10,
		STATE_D = 2'b11
	} state_t;
	
	state_t state, next_state;

	// State Transition Logic
	always @(*) begin
		case (state)
			STATE_A: next_state = in ? STATE_B : STATE_A;
			STATE_B: next_state = in ? STATE_B : STATE_C;
			STATE_C: next_state = in ? STATE_D : STATE_A;
			STATE_D: next_state = in ? STATE_B : STATE_C;
			default: next_state = STATE_A; // Default state, should never reach here
		endcase
	end

	// Output Logic
	always @(*) begin
		case (state)
			STATE_D: out = 1;
			default: out = 0;
		endcase
	end

	// State Register with synchronous active high reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= STATE_A;
		else
			state <= next_state;
	end

endmodule
