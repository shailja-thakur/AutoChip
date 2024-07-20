module top_module(
	input clk,
	input reset,
	output reg shift_ena); // Added "reg" to declare shift_ena as a register

	reg [2:0] state; // Added state register to keep track of FSM state

	always @(posedge clk) begin
		if (reset) begin
			shift_ena <= 1; // Set shift_ena to 1 during reset
			state <= 0; // Reset the state to 0
		end else begin
			shift_ena <= 0; // Set shift_ena to 0 after 4 clock cycles
			case (state) // Implement FSM behavior
				0: begin
					if ( bit_pattern_detected ) begin
						shift_ena <= 1; // Enable shift_ena for 4 clock cycles
						state <= 1; // Transition to state 1
					end else begin
						state <= 0; // Stay in state 0
					end
				end
				1: begin
					shift_ena <= 1; // Enable shift_ena for 4 clock cycles
					state <= 2; // Transition to state 2
				end
				2: begin
					shift_ena <= 1; // Enable shift_ena for 4 clock cycles
					state <= 3; // Transition to state 3
				end
				3: begin
					shift_ena <= 1; // Enable shift_ena for 4 clock cycles
					state <= 0; // Transition back to state 0
				end
			endcase
		end
	end
endmodule
