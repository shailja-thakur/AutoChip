module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	// Define states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	// Define state register and next state
	reg [2:0] state_reg, next_state_reg;

	// Define output signals
	reg done_reg;

	// Define start bit, data bits, and stop bit
	reg start_bit;
	reg [7:0] data_bits;
	reg stop_bit;

	// Define counters
	reg [2:0] bit_count;
	reg [2:0] byte_count;

	// Synchronous always block for state transitions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= IDLE;
			next_state_reg <= IDLE;
			done_reg <= 0;
		end else begin
			state_reg <= next_state_reg;
		end
	end

	// Combinational logic for next_state_reg
	always @(*) begin
		case (state_reg)
			IDLE:
				if (in == 1'b0) begin
					next_state_reg = START_BIT;
				end else begin
					next_state_reg = IDLE;
				end
			START_BIT:
				next_state_reg = DATA_BITS;
			DATA_BITS:
				if (bit_count == 2'd7) begin
					next_state_reg = STOP_BIT;
				end else begin
					next_state_reg = DATA_BITS;
				end
			STOP_BIT:
				if (in == 1'b1) begin
					next_state_reg = IDLE;
				end else begin
					next_state_reg = STOP_BIT;
				end
		endcase
	end

	// Synchronous always block for output and counters
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			done_reg <= 0;
			start_bit <= 1'b0;
			data_bits <= 8'b0;
			stop_bit <= 1'b0;
			bit_count <= 2'd0;
			byte_count <= 2'd0;
		end else if (state_reg == START_BIT) begin
			start_bit <= in;
		end else if (state_reg == DATA_BITS) begin
			data_bits[bit_count] <= in;
			bit_count <= bit_count + 1;
		end else if (state_reg == STOP_BIT) begin
			stop_bit <= in;
			bit_count <= 2'd0;
			byte_count <= byte_count + 1;
		end

		if (byte_count >= 2'd1 && state_reg == IDLE) begin
			done_reg <= 1;
		end
	end

	// Assign output to done_reg
	assign done = done_reg;

endmodule
