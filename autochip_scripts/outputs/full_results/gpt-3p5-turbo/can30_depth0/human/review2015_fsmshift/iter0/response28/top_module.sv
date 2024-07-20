module top_module(
	input clk,
	input reset,
	output shift_ena);

	// Internal signal
	reg [3:0] shift_counter;

	// FSM states
	reg [1:0] state;
	parameter IDLE = 2'b00;
	parameter ENABLE = 2'b01;
	parameter DISABLE = 2'b10;

	// Initial state
	assign shift_ena = 1'b0;

	// Counter for shift_ena cycles
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			shift_counter <= 4'b0;
		else if (state == ENABLE)
		begin
			if (shift_counter < 4'b1111)
				shift_counter <= shift_counter + 1'b1;
		end
	end

	// FSM transitions
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= IDLE;
		else if (state == IDLE)
		begin
			if (bit_pattern_detected)
				state <= ENABLE;
		end
		else if (state == ENABLE)
		begin
			if (shift_counter == 4'b1111)
				state <= DISABLE;
		end
		else if (state == DISABLE)
		begin
			state <= IDLE;
		end
	end

	// Output logic
	always @(posedge clk)
	begin
		if (reset)
			shift_ena <= 1'b0;
		else if (state == ENABLE && shift_counter < 4'b1111)
			shift_ena <= 1'b1;
		else
			shift_ena <= 1'b0;
	end

endmodule
