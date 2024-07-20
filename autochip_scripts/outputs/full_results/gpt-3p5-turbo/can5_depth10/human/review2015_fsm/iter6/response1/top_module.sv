module top_module(
	input clk,
	input reset,
	input data,
	output reg shift_ena,
	output reg counting,
	input done_counting,
	output reg done,
	input ack );

	reg [2:0] state;
	reg [2:0] next_state;
	reg [3:0] count;
	wire seq_detected;

	parameter IDLE = 0;
	parameter DETECT = 1;
	parameter SHIFT = 2;
	parameter COUNT = 3;
	parameter NOTIFY = 4;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			count <= 0;
		end else begin
			state <= next_state;
		end
	end

	always @(state or data or done_counting or ack) begin
		shift_ena = 0;
		counting = 0;
		done = 0;

		case (state)
			IDLE: begin
				if (data == 4'b1101) begin
					next_state = DETECT;
				end
			end

			DETECT: begin
				if (data == 4'b1101) begin
					next_state = SHIFT;
				end else begin
					next_state = IDLE;
				end
			end

			SHIFT: begin
				if (count < 3) begin
					count <= count + 1;
					shift_ena <= 1;
				end else begin
					next_state = COUNT;
					counting <= 1;
				end
			end

			COUNT: begin
				if (done_counting) begin
					next_state = NOTIFY;
				end
			end

			NOTIFY: begin
				if (ack) begin
					next_state = IDLE;
					done <= 1;
					shift_ena <= 0;
					counting <= 0;
				end
			end
		endcase
	end

	assign seq_detected = (state == DETECT || state == SHIFT || state == COUNT || state == NOTIFY);

endmodule
