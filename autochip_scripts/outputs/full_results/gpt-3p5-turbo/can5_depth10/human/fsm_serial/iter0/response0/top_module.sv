module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// State definition
	typedef enum logic [3:0] {
		IDLE,
		START,
		DATA,
		STOP
	} state_t;

	// Signals
	logic start_bit;
	logic [7:0] data_bits;
	logic stop_bit;
	logic [2:0] bit_counter;
	state_t state;

	// Outputs
	reg done;

	// State register
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset) begin
			state <= IDLE;
			bit_counter <= 3'd0;
			done <= 1'b0;
		end
		else begin
			case (state)
				IDLE:
					if (in == 1'b0)
						state <= START;
				START:
					if (bit_counter == 3'd7)
						state <= STOP;
					else
						state <= DATA;
				DATA:
					if (bit_counter == 3'd0)
						state <= STOP;
				STOP:
					state <= IDLE;
			endcase
		end
	end

	// Output logic
	always_ff @(posedge clk)
	begin
		if (reset)
			done <= 1'b0;
		else if (state == STOP)
			done <= 1'b1;
		else
			done <= 1'b0;
	end

	// Bit counter increment
	always_ff @(posedge clk)
	begin
		if (reset || state == IDLE)
			bit_counter <= 3'd0;
		else if (bit_counter == 3'd7 || state == STOP)
			bit_counter <= 3'd0;
		else
			bit_counter <= bit_counter + 3'd1;
	end

	// Signal assignments
	always_comb
	begin
		case (state)
			IDLE:
				start_bit = 1'b1;
				data_bits = 8'b0;
				stop_bit = 1'b1;
			START:
				start_bit = 1'b0;
				data_bits = {data_bits[6:0], in};
				stop_bit = 1'b1;
			DATA:
				start_bit = 1'b0;
				data_bits = {data_bits[6:0], in};
				stop_bit = 1'b1;
			STOP:
				start_bit = 1'b0;
				data_bits = {data_bits[6:0], in};
				stop_bit = in;
		endcase
	end

endmodule
