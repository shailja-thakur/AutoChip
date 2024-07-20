module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);
	
	// State encoding
	typedef enum logic [2:0] {
		STATE_IDLE = 3'b000,
		STATE_1    = 3'b001,
		STATE_11   = 3'b010,
		STATE_110  = 3'b011,
		STATE_1101 = 3'b100
	} state_t;
	
	state_t state, next_state;

	// Sequential logic for state transition
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= STATE_IDLE;
		end else begin
			state <= next_state;
		end
	end
	
	// Combinational logic for next state logic
	always_comb begin
		case(state)
			STATE_IDLE: begin
				if (data) 
					next_state = STATE_1;
				else
					next_state = STATE_IDLE;
			end
			STATE_1: begin
				if (data)
					next_state = STATE_11;
				else
					next_state = STATE_IDLE;
			end
			STATE_11: begin
				if (data)
					next_state = STATE_11;
				else
					next_state = STATE_110;
			end
			STATE_110: begin
				if (data)
					next_state = STATE_1101;
				else
					next_state = STATE_IDLE;
			end
			STATE_1101: begin
				next_state = STATE_1101;  // Remain in this state once sequence is detected
			end
			default: next_state = STATE_IDLE;
		endcase
	end
	
	// Combinational logic for output
	always_ff @(posedge clk) begin
		if (reset)
			start_shifting <= 0;
		else if (state == STATE_1101)
			start_shifting <= 1;
	end
	
endmodule
