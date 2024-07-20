module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output wire [3:0] count,
	output reg counting,
	output reg done,
	input wire ack );

	reg [3:0] delay;
	reg [3:0] counter;
	reg [3:0] remaining;

	parameter STATE_IDLE = 2'b00;
	parameter STATE_START_PATTERN = 2'b01;
	parameter STATE_SHIFT_IN_DELAY = 2'b10;
	parameter STATE_COUNTING = 2'b11;

	reg [1:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= STATE_IDLE;
			counter <= 0;
			remaining <= 0;
			done <= 0;
			counting <= 0;
		end else begin
			case(state)
				STATE_IDLE: begin
					if (data == 4'b1101) begin
						state <= STATE_SHIFT_IN_DELAY;
						counter <= 0;
						delay <= 0;
					end
				end
				STATE_SHIFT_IN_DELAY: begin
					state <= STATE_COUNTING;
					counting <= 1;
					delay <= data;
				end
				STATE_COUNTING: begin
					if (counter == (delay + 1) * 1000) begin
						state <= STATE_IDLE;
						counting <= 0;
						done <= 1;
						remaining <= delay;
					end else begin
						counter <= counter + 1;
						remaining <= delay - (counter / 1000);
					end
				end
			endcase
		end
	end
	
	assign count = counting ? remaining : 4'bxxxx;

endmodule
