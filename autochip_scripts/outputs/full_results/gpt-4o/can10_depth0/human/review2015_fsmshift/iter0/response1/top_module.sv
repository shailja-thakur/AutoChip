module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	// State declaration
	typedef enum reg [1:0] {
		IDLE = 2'b00,
		SHIFT1 = 2'b01,
		SHIFT2 = 2'b10,
		SHIFT3 = 2'b11
	} state_t;

	// State register
	state_t state, next_state;
	
	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			state <= SHIFT1;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and shift_ena output logic
	always @(*) begin
		case (state)
			IDLE: begin
				shift_ena = 0;
				next_state = IDLE;
			end
			SHIFT1: begin
				shift_ena = 1;
				next_state = SHIFT2;
			end
			SHIFT2: begin
				shift_ena = 1;
				next_state = SHIFT3;
			end
			SHIFT3: begin
				shift_ena = 1;
				next_state = IDLE;
			end
			default: begin
				shift_ena = 0;
				next_state = IDLE;
			end
		endcase
	end

endmodule
