module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output reg [3:0] count,
	output reg counting,
	output reg done,
	input wire ack );
	
	reg [3:0] delay;
	reg [3:0] state;

	// Start state
	localparam START = 4'b0000;
	// Searching for start sequence
	localparam SEARCH = 4'b0001;
	// Reading delay value
	localparam READ_DELAY = 4'b0010;
	// Countdown
	localparam COUNTDOWN = 4'b0011;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset state machine and delay value
			state <= START;
			delay <= 4'b0000;
			counting <= 0;
			done <= 0;
			count <= 4'b0000;
		end else begin
			case (state)
				START: begin
					// Start searching for start sequence
					if (data == 4'b1101)
						state <= SEARCH;
				end
				SEARCH: begin
					// Read delay value
					state <= READ_DELAY;
				end
				READ_DELAY: begin
					// Shift in delay value
					delay <= {data, delay[3:1]};
					state <= COUNTDOWN;
				end
				COUNTDOWN: begin
					// Start counting
					counting <= 1;
					if (count < (delay + 1))
						count <= count + 1;
					else begin
						done <= 1;
						state <= START;
						counting <= 0;
						count <= 4'b0000;
					end
				end
			endcase
		end
	end
	
	always @(negedge clk) begin
		// Update count output
		if (state == COUNTDOWN && counting)
			count <= delay - count;
	end
endmodule
