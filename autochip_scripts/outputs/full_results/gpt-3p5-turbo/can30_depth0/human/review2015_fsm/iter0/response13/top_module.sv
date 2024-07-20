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
	parameter DETECTED = 1;
	parameter SHIFTING = 2;
	parameter WAITING = 3;
	parameter DONE = 4;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			shift_ena <= 0;
			counting <= 0;
			done <= 0;
		end else begin
			case(state)
				IDLE: begin
					if (data == 4'b1101) begin
						shift_ena <= 1;
						state <= DETECTED;
					end
				end
				DETECTED: begin
					shift_ena <= 1;
					state <= SHIFTING;
				end
				SHIFTING: begin
					if (shift_ena == 4'b1111) begin
						shift_ena <= 0;
						state <= WAITING;
					end else begin
						shift_ena <= shift_ena + 1;
					end
				end
				WAITING: begin
					counting <= 1;
					if (done_counting) begin
						done <= 1;
						state <= DONE;
					end
				end
				DONE: begin
					if (ack) begin
						state <= IDLE;
						done <= 0;
					end
				end
			endcase
		end
	end

endmodule
