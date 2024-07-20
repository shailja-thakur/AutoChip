module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	// Internal signals
	reg [3:0] delay;
	reg [3:0] remaining_time;
	reg start_sequence_detected;
	reg [2:0] state;

	// Parameters
	parameter [2:0] STATE_IDLE = 3'b000;
	parameter [2:0] STATE_DETECT_START = 3'b001;
	parameter [2:0] STATE_SHIFT_DELAY = 3'b010;
	parameter [2:0] STATE_COUNTING = 3'b011;
	parameter [2:0] STATE_WAIT_ACK = 3'b100;

	// State machine
	always @(posedge clk) begin
		if (reset) begin
			state <= STATE_IDLE;
			counting <= 0;
			done <= 0;
			start_sequence_detected <= 0;
			remaining_time <= 0;
		end else begin
			case (state)
				STATE_IDLE: begin
					if (data == 4'b1101) begin
						state <= STATE_DETECT_START;
						start_sequence_detected <= 1;
					end
				end
				STATE_DETECT_START: begin
					state <= STATE_SHIFT_DELAY;
				end
				STATE_SHIFT_DELAY: begin
                    delay <= data;
					state <= STATE_COUNTING;
					counting <= 1;
                    remaining_time <= delay;
				end
				STATE_COUNTING: begin
					if (remaining_time == 0) begin
						state <= STATE_WAIT_ACK;
						counting <= 0;
						done <= 1;
					end else begin
						remaining_time <= remaining_time - 1;
					end
				end
				STATE_WAIT_ACK: begin
					if (ack) begin
						state <= STATE_IDLE;
						done <= 0;
						start_sequence_detected <= 0;
					end
				end
			endcase
		end
	end

	// Output assignments
	assign count = counting ? remaining_time : 0;

endmodule
