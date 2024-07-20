module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state;
	reg [1:0] next_state;
	reg [1:0] cycle_count;

	// State encoding
	localparam S_IDLE = 2'b00,
		   S_SHIFT = 2'b01;

	// State transition logic
	always @(posedge clk) begin
		if (reset) begin
			state <= S_IDLE;
			cycle_count <= 2'b00;
		end
		else begin
			state <= next_state;
			if (state == S_SHIFT) 
				cycle_count <= cycle_count + 1;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			S_IDLE: begin
				if (reset)
					next_state = S_SHIFT;
				else
					next_state = S_IDLE;
			end
			S_SHIFT: begin
				if (cycle_count == 2'b11)
					next_state = S_IDLE;
				else
					next_state = S_SHIFT;
			end
			default: next_state = S_IDLE;
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			S_IDLE: shift_ena = 1'b0;
			S_SHIFT: shift_ena = 1'b1;
			default: shift_ena = 1'b0;
		endcase
	end
endmodule
