module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// Define the states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BIT_1,
		DATA_BIT_8,
		STOP_BIT,
		ERROR
	} state_t;

	// Define the state and next_state variables
	state_t state, next_state;

	reg done;
	reg [7:0] data;
	reg start_bit_detected;
	reg stop_bit_detected;

	always_ff @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
			data <= 0;
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
		end else begin
			state <= next_state;
			done <= 0;
			data <= data;
			start_bit_detected <= start_bit_detected;
			stop_bit_detected <= stop_bit_detected;
		end
	end

	always_comb begin
		next_state = state;
		
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					next_state = START_BIT;
					start_bit_detected = 1;
				end
			end

			START_BIT: begin
				next_state = DATA_BIT_1;
				data[0] = in;
			end

			DATA_BIT_1: begin
				next_state = DATA_BIT_8;
				data[1] = in;
			end

			DATA_BIT_8: begin
				if (data == 8'd255 && in == 1'b0) begin
					next_state = STOP_BIT;
					stop_bit_detected = 1;
				end else begin
					next_state = ERROR;
				end
			end

			STOP_BIT: begin
				next_state = IDLE;
				done = 1;
				data = 0;
				start_bit_detected = 0;
				stop_bit_detected = 0;
			end

			ERROR: begin
				next_state = IDLE;
				done = 0;
				data = 0;
				start_bit_detected = 0;
				stop_bit_detected = 0;
			end
		endcase
	end

endmodule
