module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	reg shift_ena;

	parameter IDLE = 0;
	parameter DETECT_PATTERN = 1;
	parameter SHIFT_ENABLE = 2;

	always @(posedge clk) begin
		if (reset) begin
			// Reset the FSM
			state <= IDLE;
			shift_ena <= 0;
		end else begin
			case (state)
				IDLE:
					// Check for the specific bit pattern
					if (/*bit pattern detected*/) begin
						state <= DETECT_PATTERN;
					end
				DETECT_PATTERN:
					begin
						state <= SHIFT_ENABLE;
						shift_ena <= 1; // Initialize shift_ena to 1
					end
				SHIFT_ENABLE:
					begin
						if (/*counter reaches 4*/) begin
							state <= IDLE;
							shift_ena <= 0; // Disable shift_ena
						end
						else begin
							state <= SHIFT_ENABLE;
						end
					end
			endcase
		end
	end
endmodule
