module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// Define states
	parameter IDLE = 1'b0;
	parameter START = 1'b1;
	parameter RECEIVE_DATA = 2'b01;
	parameter VERIFY_STOP = 2'b10;

	// Define current state and next state
	reg [1:0] state, next_state;

	// Define internal signals
	reg start_bit_flag, stop_bit_flag;
	reg [7:0] data_byte;
	reg [2:0] bit_counter;

	// Synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// Output logic
	always @(state, bit_counter, in) begin
		// Default values
		done = 0;
		out_byte = 8'b00000000;

		case (state)
			IDLE: begin
				// Check for start bit
				if (in == 1'b0)
					next_state = START;
				else
					next_state = IDLE;
			end
			START: begin
				// Wait for all 8 data bits
				next_state = RECEIVE_DATA;
				start_bit_flag = 1;
				bit_counter = 0;
			end
			RECEIVE_DATA: begin
				// Receive data bits
				if (bit_counter < 8)
					data_byte[bit_counter] = in;
				bit_counter = bit_counter + 1;

				// Check for stop bit
				if (bit_counter >= 8)
					next_state = VERIFY_STOP;
				else
					next_state = RECEIVE_DATA;
			end
			VERIFY_STOP: begin
				// Verify stop bit
				if (in == 1'b1)
					stop_bit_flag = 1;
				else
					stop_bit_flag = 0;
				
				// Output valid data byte
				if (start_bit_flag && stop_bit_flag) begin
					out_byte = data_byte;
					done = 1;
				end
				
				// Reset flags and counter
				start_bit_flag = 0;
				stop_bit_flag = 0;
				bit_counter = 0;
				
				// Transition back to IDLE or START
				if (in == 1'b1)
					next_state = IDLE;
				else
					next_state = START;
			end
		endcase
	end

endmodule
