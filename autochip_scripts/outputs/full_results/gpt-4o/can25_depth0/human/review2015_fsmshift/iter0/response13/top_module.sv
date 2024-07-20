module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	// State definition
	typedef enum reg [2:0] {
		IDLE  = 3'b000,
		S1    = 3'b001,
		S2    = 3'b010,
		S3    = 3'b011,
		S4    = 3'b100
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(posedge clk) begin
		if (reset) 
			state <= S1;
		else 
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: next_state = IDLE; // Remain in IDLE unless reset
			S1:   next_state = S2;
			S2:   next_state = S3;
			S3:   next_state = S4;
			S4:   next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) 
			shift_ena <= 1'b1;
		else if (state == IDLE) 
			shift_ena <= 1'b0;
		else 
			shift_ena <= 1'b1;
	end

endmodule
