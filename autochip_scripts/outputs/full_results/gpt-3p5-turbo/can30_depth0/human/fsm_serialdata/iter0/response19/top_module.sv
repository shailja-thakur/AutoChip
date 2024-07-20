module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	
	reg [2:0] state;
	reg [7:0] data_byte;
	reg [2:0] count;
	reg start_bit_detected;
	reg stop_bit_detected;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			data_byte <= 0;
			count <= 0;
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
			done <= 0;
		end else begin
			case(state)
				0: begin // Idle state
					if (in == 0) begin
						state <= 1; // Start bit detected, transition to next state
					end
				end
				1: begin // Start bit detected state
					if (in == 0) begin
						state <= 2; // Transition to next state
						count <= 0; // Reset count
					end else begin
						state <= 0; // Start bit not detected, go back to idle state
					end
				end
				2: begin // Data bits state
					if (count < 8) begin // If count is less than 8, still receiving data bits
						data_byte[count] <= in;
						count <= count + 1;
					end else begin
						state <= 3; // All data bits received, transition to next state
					end
				end
				3: begin // Stop bit state
					if (in == 1) begin
						state <= 4; // Stop bit detected, transition to next state
					end else begin
						state <= 0; // Stop bit not detected, go back to idle state
					end
				end
				4: begin // Byte received state
					start_bit_detected <= 0; // Reset start bit flag
					stop_bit_detected <= 1; // Set stop bit flag
					out_byte <= data_byte; // Output received byte
					done <= 1; // Byte reception complete, assert done
					state <= 0; // Transition back to idle state
				end
			endcase
		end
	end
endmodule
