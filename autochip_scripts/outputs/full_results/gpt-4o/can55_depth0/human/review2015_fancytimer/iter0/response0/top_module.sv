module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	// State Encoding
	localparam WAIT_PATTERN = 4'd0;
	localparam SHIFT_DELAY = 4'd1;
	localparam COUNTING = 4'd2;
	localparam DONE = 4'd3;

	reg [3:0] state, next_state;
	reg [3:0] data_shift;
	reg [3:0] delay;
	reg [15:0] counter;
	reg [2:0] bit_counter; // To count the number of bits shifted for reading delay

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= WAIT_PATTERN;
			data_shift <= 4'b0;
			counting <= 0;
			done <= 0;
			counter <= 16'b0;
			delay <= 4'b0;
			count <= 4'bx;
			bit_counter <= 3'b0;
		end
		else begin
			state <= next_state;

			// State actions
			case (state)
				WAIT_PATTERN: begin
					data_shift <= {data_shift[2:0], data}; // Shift in bits
					if (data_shift == 4'b1101) begin
						next_state <= SHIFT_DELAY;
						bit_counter <= 3'b0;
					end
				end
				SHIFT_DELAY: begin
					data_shift <= {data_shift[2:0], data}; // Shift in bits to form delay
					bit_counter <= bit_counter + 1;
					if (bit_counter == 3'b011) begin
						delay <= {data_shift[2:0], data}; // Capture the delay value
						next_state <= COUNTING;
						counter <= 1000 * ({data_shift[2:0], data} + 1);
						counting <= 1;
					end
				end
				COUNTING: begin
					if (counter > 0) begin
						counter <= counter - 1;
						count <= (counter / 1000);
					end
					else begin
						counting <= 0;
						done <= 1;
						next_state <= DONE;
					end
				end
				DONE: begin
					if (ack) begin
						done <= 0;
						next_state <= WAIT_PATTERN;
					end
				end
			endcase
		end
	end

	// Next state logic
	always @(*) begin
		next_state = state; // By default, stay in current state
		case (state)
			WAIT_PATTERN: begin
				if (data_shift == 4'b1101)
					next_state = SHIFT_DELAY;
			end
			SHIFT_DELAY: begin
				if (bit_counter == 3'b011)
					next_state = COUNTING;
			end
			COUNTING: begin
				if (counter == 0)
					next_state = DONE;
			end
			DONE: begin
				if (ack)
					next_state = WAIT_PATTERN;
			end
		endcase
	end

endmodule
