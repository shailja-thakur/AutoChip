module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] delay;
	reg [2:0] state;
	reg [3:0] count_reg;
	reg [3:0] remaining_time;

	parameter [3:0] START = 4'b1101;

	// State machine states
	parameter [2:0] IDLE = 3'b000;
	parameter [2:0] SHIFT_IN = 3'b001;
	parameter [2:0] COUNTING = 3'b010;
	parameter [2:0] WAIT_ACK = 3'b011;

	// Default values
	assign count = count_reg;
	assign counting = state == COUNTING;
	assign remaining_time = delay;

	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
			count_reg <= 0;
			delay <= 0;
		end else begin			
			case (state)
				IDLE: begin
					if (data == START) begin
						state <= SHIFT_IN;
						delay <= 0;
					end else begin
						state <= IDLE;
						done <= 0;
					end
					count_reg <= 0;
				end
				SHIFT_IN: begin
					delay <= {data, delay[3:1]};
					state <= COUNTING;
					count_reg <= delay + 1;
				end
				COUNTING: begin
					if (count_reg == 0) begin
						state <= WAIT_ACK;
					end else begin
						state <= COUNTING;
						count_reg <= count_reg - 1;
					end
				end
				WAIT_ACK: begin
					if (ack) begin
						state <= IDLE;
						done <= 1;
					end else begin
						state <= WAIT_ACK;
						done <= 0;
					end
				end
			endcase
		end
	end

endmodule
