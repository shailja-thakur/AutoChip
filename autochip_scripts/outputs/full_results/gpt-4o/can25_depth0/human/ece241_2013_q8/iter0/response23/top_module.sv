module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		S1 = 2'b01,
		S10 = 2'b10
	} state_t;
	
	state_t current_state, next_state;

	// State transition logic
	always @(posedge clk or negedge aresetn) begin
		if (!aresetn)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	// Next state logic
	always @(*) begin
		z = 1'b0;  // Default to 0
		case (current_state)
			IDLE: begin
				if (x)
					next_state = S1;
				else
					next_state = IDLE;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S10;
			end
			S10: begin
				if (x) begin
					next_state = S1;
					z = 1'b1;  // Sequence "101" detected
				} else
					next_state = IDLE;
			end
			default: next_state = IDLE;
		endcase
	end

endmodule
