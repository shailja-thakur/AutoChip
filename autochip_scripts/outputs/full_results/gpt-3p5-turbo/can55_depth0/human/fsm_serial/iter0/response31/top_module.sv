module top_module (
	input clk,
	input in,
	input reset,
	output done
);

// State definitions
typedef enum logic [2:0] {
	IDLE,
	WAIT_START_BIT,
	RECEIVE_DATA_BITS,
	WAIT_STOP_BIT
} state_t;

// Register for state storage
reg [2:0] current_state = IDLE;

// Register for data bit counter
reg [2:0] data_bit_counter = 0;

// Register for received data bits
reg [7:0] received_data;

// Register for start bit detection
reg start_bit_detected = 0;

// Register for stop bit detection
reg stop_bit_detected = 0;

// Counter for detecting stop bit position
reg [2:0] stop_bit_counter;

// Output register for done signal
reg done_reg;

// Synchronous reset
always_ff @(posedge clk, posedge reset) begin
	if (reset)
		current_state <= IDLE;
	else
		current_state <= next_state;
end

// Next state logic and data bit processing
always_comb begin
	case (current_state)
		IDLE: begin
			if (reset)
				next_state = IDLE;
			else if (start_bit_detected)
				next_state = WAIT_START_BIT;
			else
				next_state = IDLE;

			// Reset control signals and counters
			data_bit_counter = 0;
			received_data = 0;
			stop_bit_detected = 0;
			stop_bit_counter = 0;
			done_reg = 0;
		end

		WAIT_START_BIT: begin
			if (reset)
				next_state = IDLE;
			else if (in == 0)
				next_state = RECEIVE_DATA_BITS;
			else
				next_state = WAIT_START_BIT;

			// Check for start bit detection
			if (in == 0)
				start_bit_detected = 1;
			else
				start_bit_detected = 0;
		end

		RECEIVE_DATA_BITS: begin
			if (reset)
				next_state = IDLE;
			else if (data_bit_counter == 7)
				next_state = WAIT_STOP_BIT;
			else
				next_state = RECEIVE_DATA_BITS;

			// Shift in received data bit
			received_data[data_bit_counter] = in;

			// Increment data bit counter
			data_bit_counter = data_bit_counter + 1;
		end

		WAIT_STOP_BIT: begin
			if (reset)
				next_state = IDLE;
			else if (in == 1 && stop_bit_counter == 3)
				next_state = IDLE;
			else
				next_state = WAIT_STOP_BIT;

			// Check for stop bit detection
			if (in == 1)
				stop_bit_detected = 1;
			else
				stop_bit_detected = 0;

			// Increment stop bit counter
			stop_bit_counter = stop_bit_counter + 1;
		end
	endcase
end

// Output signal assignment
assign done = done_reg;

// Done signal generation
always_comb begin
	if (current_state == IDLE && start_bit_detected && stop_bit_detected)
		done_reg = 1;
	else
		done_reg = 0;
end

endmodule
