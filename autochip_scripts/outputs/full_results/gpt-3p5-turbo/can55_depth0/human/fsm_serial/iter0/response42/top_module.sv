module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// States of the finite state machine
	parameter [1:0] IDLE = 2'b00;
	parameter [1:0] START_BIT = 2'b01;
	parameter [1:0] DATA_BITS = 2'b10;
	parameter [1:0] STOP_BIT = 2'b11;

	// Outputs
	wire start_bit_detected;
	
	// Flip-flops for the state machine
	reg [1:0] current_state;
	reg [1:0] next_state;

	// Counter for counting the received data bits
	reg [2:0] data_bit_counter;

	// Start bit detection logic
	assign start_bit_detected = (current_state == START_BIT) ? 1'b1 : 1'b0;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Synchronous reset
			current_state <= IDLE;
			data_bit_counter <= 3'b0;
		end else begin
			current_state <= next_state;

			// State transition logic
			case (current_state)
				IDLE: begin
					// Wait for the start bit to be detected
					if (in == 1'b0) begin
						next_state <= START_BIT;
						data_bit_counter <= 3'b0;
					end else begin
						next_state <= IDLE;
						data_bit_counter <= 3'b0;
					end
				end

				START_BIT: begin
					// Wait for the start bit to end
					if (in == 1'b1) begin
						next_state <= DATA_BITS;
						data_bit_counter <= 3'b0;
					end else begin
						next_state <= START_BIT;
						data_bit_counter <= 3'b0;
					end
				end

				DATA_BITS: begin
					// Count the received data bits
					if (data_bit_counter < 3'b111) begin
						next_state <= DATA_BITS;
						data_bit_counter <= data_bit_counter + 1'b1;
					end else begin
						next_state <= STOP_BIT;
						data_bit_counter <= 3'b0;
					end
				end

				STOP_BIT: begin
					// Verify the stop bit
					if (in == 1'b1) begin
						next_state <= IDLE;
						data_bit_counter <= 3'b0;
					end else begin
						next_state <= START_BIT;
						data_bit_counter <= 3'b0;
					end
				end
			endcase
		end
	end

	// Output done signal when a byte has been correctly received
	assign done = (current_state == IDLE) ? 1'b1 : 1'b0;

endmodule
