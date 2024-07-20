module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// Define states
	typedef enum logic [2:0] {
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_type;

	// Define signals
	logic [2:0] state;
	logic [2:0] next_state;
	logic [7:0] data_bits;
	logic start_bit_detected;
	logic stop_bit_detected;

	// Next state logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= START_BIT;
			data_bits <= '0;
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
		end else begin
			state <= next_state;
			if (state == START_BIT) begin
				data_bits <= '0;
				start_bit_detected <= in;
			end else if (state == DATA_BITS) begin
				data_bits <= {data_bits[6:0], in};
			end else if (state == STOP_BIT) begin
				stop_bit_detected <= in;
			end
		end
	end

	// Output logic
	always_comb begin
		out_byte = data_bits;
		done = stop_bit_detected;
	end

	// State transition and output logic
	always_comb begin
		case (state)
			START_BIT: begin
				if (start_bit_detected) begin
					next_state = DATA_BITS;
				end else begin
					next_state = START_BIT;
				end
			end
			DATA_BITS: begin
				if (data_bits[0] && data_bits[7:1] && !start_bit_detected) begin
					next_state = STOP_BIT;
				end else begin
					next_state = DATA_BITS;
				end
			end
			STOP_BIT: begin
				if (!stop_bit_detected) begin
					next_state = START_BIT;
				end else begin
					next_state = START_BIT;
				end
			end
		endcase
	end

endmodule
