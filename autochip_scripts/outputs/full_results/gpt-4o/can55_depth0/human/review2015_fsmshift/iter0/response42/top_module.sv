module top_module(
	input clk,
	input reset,
	output reg shift_ena);
	
	reg [2:0] state, next_state;

	// States
	localparam IDLE   = 3'b000;
	localparam SHIFT1 = 3'b001;
	localparam SHIFT2 = 3'b010;
	localparam SHIFT3 = 3'b011;
	localparam SHIFT4 = 3'b100;

	// State transition logic
	always @(posedge clk) begin
		if (reset)
			state <= SHIFT1;  // Initialize state to SHIFT1 on reset
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case(state)
			IDLE: begin
				shift_ena = 1'b0;
				next_state = IDLE;
			end
			SHIFT1: begin
				shift_ena = 1'b1;
				next_state = SHIFT2;
			end
			SHIFT2: begin
				shift_ena = 1'b1;
				next_state = SHIFT3;
			end
			SHIFT3: begin
				shift_ena = 1'b1;
				next_state = SHIFT4;
			end
			SHIFT4: begin
				shift_ena = 1'b1;
				next_state = IDLE;
			end
			default: begin
				shift_ena = 1'b0;
				next_state = IDLE;
			end
		endcase
	end

endmodule
