module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// Define state names using parameters for readability
	parameter IDLE       = 3'b000;
	parameter START_BIT  = 3'b001;
	parameter DATA_BITS  = 3'b010;
	parameter STOP_BIT   = 3'b011;
	parameter ERROR      = 3'b100;

	reg [2:0] state, next_state;
	reg [3:0] bit_count;  // to count the 8 data bits

	// Synchronous reset and state transition
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			bit_count <= 4'd0;
		end
		else begin
			state <= next_state;
			if (state == DATA_BITS)
				bit_count <= bit_count + 1'b1;
			else
				bit_count <= 4'd0;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			IDLE: begin
				if (in == 1'b0)  // Detect start bit (which is 0)
					next_state = START_BIT;
				else
					next_state = IDLE;
				done = 1'b0;
			end

			START_BIT: begin
				if (in == 1'b0)  // Stay in start bit state till start bit is valid
					next_state = DATA_BITS;
				else
					next_state = IDLE;
				done = 1'b0;
			end

			DATA_BITS: begin
				if (bit_count == 4'd8)  // If 8 data bits are received
					next_state = STOP_BIT;
				else
					next_state = DATA_BITS;
				done = 1'b0;
			end

			STOP_BIT: begin
				if (in == 1'b1) begin  // Check if stop bit is 1
					next_state = IDLE;
					done = 1'b1;
				end
				else begin
					next_state = ERROR;
					done = 1'b0;
				end
			end

			ERROR: begin
				if (in == 1'b1)  // Wait until a stop bit (which is 1) is found
					next_state = IDLE;
				else
					next_state = ERROR;
				done = 1'b0;
			end

			default: begin
				next_state = IDLE;
				done = 1'b0;
			end
		endcase
	end
endmodule
