module top_module (
	input clk,
	input in,
	input reset,
	output reg [7:0] out_byte,
	output reg done
);

	// FSM States
	parameter IDLE       = 3'd0;
	parameter START_BIT  = 3'd1;
	parameter DATA_BITS  = 3'd2;
	parameter STOP_BIT   = 3'd3;

	reg [2:0] state, next_state;
	reg [2:0] bit_counter;
	reg [7:0] data_byte;

	// State Transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end

	// State Output Logic and Next State Logic
	always @(*) begin
		// Default values
		done = 1'b0;
		next_state = state;

		case (state)
			IDLE: begin
				if (in == 1'b0)  // Detect start bit
					next_state = START_BIT;
			end

			START_BIT: begin
				next_state = DATA_BITS;
				bit_counter = 3'd0;  // Initialize bit counter
			end

			DATA_BITS: begin
				if (bit_counter == 3'd7)
					next_state = STOP_BIT;
				else
					next_state = DATA_BITS;
			end

			STOP_BIT: begin
				if (in == 1'b1) begin  // Stop bit must be 1
					next_state = IDLE;
					done = 1'b1;
				end
				else
					next_state = IDLE;  // Error recovery: reset to IDLE if stop bit not found
			end

			default: next_state = IDLE;
		endcase
	end

	// Data Byte Reception and Bit Counter Update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_byte <= 8'd0;
			data_byte <= 8'd0;
			bit_counter <= 3'd0;
		end
		else begin
			if (state == DATA_BITS) begin
				data_byte[bit_counter] <= in;
				if (bit_counter < 3'd7)
					bit_counter <= bit_counter + 1;
			end
			else if (state == STOP_BIT) begin
				out_byte <= data_byte;
			end
		end
	end

endmodule
