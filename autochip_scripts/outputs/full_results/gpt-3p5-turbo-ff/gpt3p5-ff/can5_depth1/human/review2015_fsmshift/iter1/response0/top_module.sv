module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [1:0] state;
	reg [1:0] next_state;
	reg [3:0] counter;

	// Define state codes
	parameter IDLE = 2'b00;
	parameter CHECK_PATTERN = 2'b01;
	parameter SHIFT_ENABLE = 2'b10;

	// Define bit pattern
	parameter PATTERN = 4'b1010;

	// Assign initial state
	// Check pattern state is active for 4 cycles, then transition to idle
	// Idle state is active until reset is asserted
	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			state <= IDLE;
			counter <= 0;
		end
		else
			state <= next_state;
	end

	// Next state logic
	always @*
	begin
		next_state = state;
		case (state)
			IDLE:
				begin
					if (!reset)
					begin
						if (PATTERN == 4'b1010)
							next_state = SHIFT_ENABLE;
						else
							next_state = CHECK_PATTERN;
					end
				end

			CHECK_PATTERN:
				begin
					if (counter == 3)
						next_state = IDLE;
					else if (PATTERN == 4'b1010)
						next_state = SHIFT_ENABLE;
					else
						next_state = CHECK_PATTERN;
				end

			SHIFT_ENABLE:
				begin
					next_state = IDLE;
				end
		endcase
	end

	// Counter to keep track of shift enable cycles
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			counter <= 0;
		else if (state == CHECK_PATTERN && counter < 3)
			counter <= counter + 1;
		else
			counter <= 0;
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
