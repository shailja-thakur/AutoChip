module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] delay;
	reg [3:0] count_down;
	reg [3:0] remaining_time;
	reg searching;
	reg counting;


	// States
	reg [1:0] state;
	parameter S_IDLE = 2'b00;
	parameter S_DETECT_PATTERN = 2'b01;
	parameter S_SHIFT_IN_DELAY = 2'b10;
	parameter S_COUNTING = 2'b11;

	always @(posedge clk) begin
		if (reset) begin
            state <= S_IDLE;
            remaining_time <= 0;
            done <= 0;
            counting <= 0;
		end else begin
			case(state)
				S_IDLE: begin
					if(data == 4'b1101) begin
						state <= S_DETECT_PATTERN;
					end
				end
				S_DETECT_PATTERN: begin
					state <= S_SHIFT_IN_DELAY;
				end
				S_SHIFT_IN_DELAY: begin
					state <= S_COUNTING;
					delay <= data;
					count_down <= (delay + 1) * 1000;
					remaining_time <= delay;
                    counting <= 1;
				end
				S_COUNTING: begin
					if (count_down == 0) begin
                        counting <= 0;
                        done <= 1;
                    end else begin
                        count_down <= count_down - 1;
                        remaining_time <= count_down % 1000;
                    end
				end
				default: begin
					state <= S_IDLE;
				end
			endcase
		end
	end

	assign count = counting ? remaining_time : 4'bXXXX;
endmodule
