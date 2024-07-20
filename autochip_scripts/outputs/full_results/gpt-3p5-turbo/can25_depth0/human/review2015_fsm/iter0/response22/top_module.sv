module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

	reg [3:0] state;

	parameter IDLE = 0;
	parameter SEARCH_PATTERN = 1;
	parameter SHIFT_IN = 2;
	parameter WAIT_COUNTING = 3;
	parameter NOTIFY_DONE = 4;
	parameter WAIT_ACK = 5;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			shift_ena <= 0;
			counting <= 0;
			done <= 0;
		end else begin
			case (state)
				IDLE:
					if (data == 4'b1101)
						state <= SEARCH_PATTERN;
				SEARCH_PATTERN:
					begin
						shift_ena <= 1;
						state <= SHIFT_IN;
					end
				SHIFT_IN:
					begin
						shift_ena <= 0;
						state <= WAIT_COUNTING;
					end
				WAIT_COUNTING:
					begin
						counting <= 1;
						if (done_counting)
							state <= NOTIFY_DONE;
					end
				NOTIFY_DONE:
					begin
						done <= 1;
						state <= WAIT_ACK;
					end
				WAIT_ACK:
					begin
						if (ack)
						begin
							state <= IDLE;
							done <= 0;
						end
					end
			endcase
		end
	end
endmodule
