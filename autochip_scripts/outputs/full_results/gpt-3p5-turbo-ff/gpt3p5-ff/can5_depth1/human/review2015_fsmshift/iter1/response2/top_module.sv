module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state;
	reg [1:0] next_state;
	reg [3:0] count;

	// Define state codes
	parameter IDLE = 2'b00;
	parameter CHECK_PATTERN = 2'b01;
	parameter SHIFT_ENABLE = 2'b10;

	// Define bit pattern
	parameter PATTERN = 4'b1010;

	// Assign initial state and count
	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			state <= IDLE;
			count <= 0;
		end
		else
			state <= next_state;
	end

	// Next state logic
	always @*
	begin
		case (state)
			IDLE:
				begin
					if (reset)
						next_state = IDLE;
					else
						next_state = CHECK_PATTERN;
				end

			CHECK_PATTERN:
				begin
					if (reset)
						next_state = IDLE;
					else if (PATTERN == 4'b1010)
					begin
						next_state = SHIFT_ENABLE;
						count <= 4;
					end
					else
						next_state = CHECK_PATTERN;
				end

			SHIFT_ENABLE:
				begin
					if (reset)
						next_state = IDLE;
					else if (count == 0)
						next_state = IDLE;
					else
					begin
						next_state = SHIFT_ENABLE;
						count <= count - 1;
					end
				end
		endcase
	end

	// Generate shift enable output
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			shift_ena <= 1'b0;
		else if (state == SHIFT_ENABLE)
			shift_ena <= 1'b1;
		else
			shift_ena <= 1'b0;
	end
endmodule
