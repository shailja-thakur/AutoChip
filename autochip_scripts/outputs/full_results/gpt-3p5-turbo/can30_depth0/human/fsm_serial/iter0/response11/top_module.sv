module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// Define states for the FSM
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	reg state_t current_state, next_state;
	reg [3:0] data_counter;
	reg start_detected, stop_detected;

	// Define constants
	parameter STOP_BIT_VALUE = 1;
	parameter DATA_BITS_COUNT = 8;

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	// Combinational logic
	always @* begin
		next_state = current_state;
		start_detected = 0;
		stop_detected = 0;

		case (current_state)
			IDLE:
				if (in == 1'b0)
					next_state = START_BIT;
			START_BIT:
				if (in == 1'b0)
					next_state = DATA_BITS;
				else if (in == 1'b1)
					next_state = IDLE;
			DATA_BITS:
				if (data_counter == DATA_BITS_COUNT && in == STOP_BIT_VALUE)
					next_state = STOP_BIT;
				else if (data_counter != DATA_BITS_COUNT)
					next_state = DATA_BITS;
				else
					next_state = IDLE;
			STOP_BIT:
				if (in == STOP_BIT_VALUE)
					next_state = IDLE;
		endcase

		if (current_state == START_BIT && in == 1'b0)
			start_detected = 1;
		
		if (current_state == STOP_BIT && in == STOP_BIT_VALUE)
			stop_detected = 1;
		
		if (next_state != DATA_BITS)
			data_counter <= 0;
		else if (in == 1'b0)
			data_counter <= data_counter + 1;
	end

	// Output
	assign done = (current_state == IDLE && start_detected && stop_detected);

endmodule
