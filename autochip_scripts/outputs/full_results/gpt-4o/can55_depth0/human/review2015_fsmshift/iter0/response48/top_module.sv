module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state, next_state;
	reg [2:0] counter;

	// State encoding
	localparam IDLE  = 2'b00,
	           SHIFT = 2'b01,
	           DONE  = 2'b10;

	// State transitions
	always @(posedge clk) begin
		if (reset)
			state <= SHIFT;
		else
			state <= next_state;
	end

	// Next state logic and output logic
	always @(*) begin
		next_state = state;
		shift_ena = 1'b0;

		case (state)
			IDLE: begin
				shift_ena = 1'b0;
				if (reset)
					next_state = SHIFT;
				else
					next_state = IDLE;
			end
			SHIFT: begin
				shift_ena = 1'b1;
				if (counter == 3'd4)
					next_state = DONE;
				else
					next_state = SHIFT;
			end
			DONE: begin
				shift_ena = 1'b0;
				if (reset)
					next_state = SHIFT;
				else
					next_state = IDLE;
			end
		endcase
	end

	// Counter for SHIFT state
	always @(posedge clk) begin
		if (reset)
			counter <= 3'd0;
		else if (state == SHIFT)
			counter <= counter + 3'd1;
		else
			counter <= 3'd0;
	end
endmodule
