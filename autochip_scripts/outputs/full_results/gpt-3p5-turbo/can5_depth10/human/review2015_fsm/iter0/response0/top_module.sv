module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

	reg [3:0] state;

	// Define states
	parameter START = 0;   // Start state, waiting for 1101 pattern
	parameter SHIFT = 1;   // Shift state, assert shift_ena for 4 clock cycles
	parameter COUNT = 2;   // Count state, wait for done_counting
	parameter NOTIFIED = 3;   // Notified state, assert done and wait for ack

	// Synchronous reset
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= START;
		else
			state <= nextState;
	end

	// Next state logic
	always @(*)
	begin
		case (state)
			START: begin
				if (data == 4'b1101)
					nextState = SHIFT;
				else
					nextState = START;
			end
			SHIFT: begin
				if (shift_ena)
					nextState = COUNT;
				else
					nextState = SHIFT;
			end
			COUNT: begin
				if (done_counting)
					nextState = NOTIFIED;
				else
					nextState = COUNT;
			end
			NOTIFIED: begin
				if (ack)
					nextState = START;
				else
					nextState = NOTIFIED;
			end
		endcase
	end

	// Output logic
	always @(state)
	begin
		case (state)
			START: begin
				shift_ena = 1'b0;
				counting = 1'b0;
				done = 1'b0;
			end
			SHIFT: begin
				shift_ena = 1'b1;
				counting = 1'b0;
				done = 1'b0;
			end
			COUNT: begin
				shift_ena = 1'b0;
				counting = 1'b1;
				done = 1'b0;
			end
			NOTIFIED: begin
				shift_ena = 1'b0;
				counting = 1'b0;
				done = 1'b1;
			end
		endcase
	end
	
endmodule
