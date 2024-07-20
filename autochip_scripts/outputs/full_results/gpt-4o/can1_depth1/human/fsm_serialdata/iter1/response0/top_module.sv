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

	// Next State Logic
	always @(*) begin
		// Default values
		next_state = state;
		case (state)
			IDLE: begin
				if (in == 1'b0)  // Detect start bit
					next_state = START_BIT;
			end
			START_BIT: begin
				next_state = DATA_BITS;
			end
			DATA_BITS: begin
				if (bit_counter == 3'd7)
					next_state = STOP_BIT;
			end
			STOP_BIT: begin
				if (in == 1'b1)  // Stop bit must be 1
					next_state = IDLE;
				else
					next_state = IDLE;  // Error recovery: reset to IDLE if stop bit not found
			end
			default: next_state = IDLE;
		endcase
	end

	// State Output Logic and Bit Counter Update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_byte <= 8'd0;
			data_byte <= 8'd0;
			bit_counter <= 3'd0;
			done <= 1'b0;
		end
		else begin
			case (state)
				IDLE: done <= 1'b0;
				START_BIT: begin
					bit_counter <= 3'd0;
					done <= 1'b0;
				end
				DATA_BITS: begin
					data_byte[bit_counter] <= in;
					if (bit_counter < 3'd7)
						bit_counter <= bit_counter + 1;
					else
						bit_counter <= 3'd0;
				end
				STOP_BIT: begin
					if (in == 1'b1) begin
						out_byte <= data_byte;
						done <= 1'b1;
					end
					else begin
						out_byte <= 8'd0;
						done <= 1'b0;
					end
				end
			endcase
		end
	end

endmodule
