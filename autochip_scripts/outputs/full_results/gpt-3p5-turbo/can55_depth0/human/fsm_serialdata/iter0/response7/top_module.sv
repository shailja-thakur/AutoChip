module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// Define the states of the finite state machine
typedef enum logic [2:0] {
	IDLE,
	START_BIT,
	DATA_BITS,
	STOP_BIT
} StateType;

// Define the signals
reg [2:0] state;
reg [7:0] byte;
reg done;
reg bit_counter;

// Reset state
always_ff @(posedge clk, posedge reset)
begin
	if (reset)
	begin
		state <= IDLE;
		byte <= 8'b0;
		done <= 0;
		bit_counter <= 0;
	end
	else
	begin
		case (state)
			IDLE:
			begin
				if (in == 1'b0) // Start bit detected
				begin
					byte <= 8'b0;
					bit_counter <= 0;
					state <= START_BIT;
				end
			end

			START_BIT:
			begin
				if (bit_counter == 8) // All data bits received
				begin
					state <= STOP_BIT;
				end
				else
				begin
					byte <= {byte[6:0], in}; // Shift in the data bits
					bit_counter <= bit_counter + 1;
				end
			end

			DATA_BITS:
			begin
				if (bit_counter == 8) // All data bits received
				begin
					state <= STOP_BIT;
				end
				else
				begin
					byte <= {byte[6:0], in}; // Shift in the data bits
					bit_counter <= bit_counter + 1;
				end
			end

			STOP_BIT:
			begin
				if (in == 1'b1) // Stop bit detected
				begin
					done <= 1; // Byte received successfully
				end
				state <= IDLE; // Wait for next start bit
			end
		endcase
	end
end

// Output the received byte when done signal is high
assign out_byte = (done) ? byte : 0;

endmodule
