module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

	// State encoding
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		BYTE1 = 2'b01,
		BYTE2 = 2'b10,
		BYTE3 = 2'b11
	} state_t;
	
	state_t current_state, next_state;

	// State transition logic
	always @(posedge clk) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (current_state)
			IDLE: 
				if (in[3] == 1)
					next_state = BYTE1;
				else
					next_state = IDLE;
			BYTE1: 
				next_state = BYTE2;
			BYTE2: 
				next_state = BYTE3;
			BYTE3: 
				next_state = IDLE;
			default: 
				next_state = IDLE;
		endcase
	end
	
	// Output logic
	always @(posedge clk) begin
		if (reset)
			done <= 0;
		else if (current_state == BYTE3)
			done <= 1;
		else
			done <= 0;
	end

endmodule
