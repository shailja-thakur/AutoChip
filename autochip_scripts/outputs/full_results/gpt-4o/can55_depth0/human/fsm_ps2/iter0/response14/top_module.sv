module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum reg [1:0] {
		STATE_IDLE = 2'b00,
		STATE_BYTE1 = 2'b01,
		STATE_BYTE2 = 2'b10,
		STATE_BYTE3 = 2'b11
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_IDLE: begin
				if (in[3]) // First byte of message has in[3] = 1
					next_state = STATE_BYTE1;
				else
					next_state = STATE_IDLE;
			end
			
			STATE_BYTE1: begin
				next_state = STATE_BYTE2;
			end
			
			STATE_BYTE2: begin
				next_state = STATE_BYTE3;
			end
			
			STATE_BYTE3: begin
				next_state = STATE_IDLE;
			end
		endcase
	end

	// State flip-flops (sequential logic)
	always @(posedge clk) begin
		if (reset)
			state <= STATE_IDLE;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			done <= 0;
		else if (state == STATE_BYTE3)
			done <= 1;
		else
			done <= 0;
	end
	
endmodule
