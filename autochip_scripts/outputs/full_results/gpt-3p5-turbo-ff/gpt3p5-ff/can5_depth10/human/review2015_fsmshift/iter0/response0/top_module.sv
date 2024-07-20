module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	// Define state enum for FSM
	typedef enum logic [1:0] { IDLE, WAIT, ENABLE } State_t;
	
	// Define state register
	reg State_t state;
	
	// Define shift register detection flag
	reg bit detected;
	
	// Define counter for tracking clock cycles
	reg [2:0] counter;
	
	// Synchronous reset
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	// Next state logic
	always_comb
	begin
		case (state)
			IDLE:
				if (detected)
					next_state = WAIT;
				else
					next_state = IDLE;
			WAIT:
				next_state = ENABLE;
			ENABLE:
				next_state = IDLE;
		endcase
	end
	
	// Detected flag logic
	always @(posedge clk)
	begin
		if (reset)
			detected <= 0;
		else
			detected <= (/* bit pattern detection condition */);
	end
	
	// Counter increment logic
	always @(posedge clk)
	begin
		if (reset)
			counter <= 0;
		else if (state == ENABLE)
			counter <= counter + 1;
		else
			counter <= 0;
	end
	
	// Shift enable logic
	always @(posedge clk)
	begin
		if (reset)
			shift_ena <= 1;
		else if (state == ENABLE && counter < 4)
			shift_ena <= 1;
		else
			shift_ena <= 0;
	end
	
endmodule
