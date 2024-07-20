module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State declarations
	typedef enum reg [1:0] {
		STATE_A = 2'b00,
		STATE_B = 2'b01
	} state_t;

	state_t state, next_state;
	
	// State transition logic
	always @(*) begin
		case (state)
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
			default: next_state = STATE_A; // Default case for safety
		endcase
	end
	
	// State flip-flops with asynchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) 
			state <= STATE_A;
		else 
			state <= next_state;
	end
	
	// Output logic
	always @(*) begin
		case (state)
			STATE_A: out = 1'b0;
			STATE_B: out = 1'b1;
			default: out = 1'b0; // Default case for safety
		endcase
	end
	
endmodule
