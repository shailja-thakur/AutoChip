module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] delay;
	reg [3:0] timer_count;
	reg [3:0] remaining_time;
	reg [3:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
		end else begin
			case(state)
				4'b0000: begin // Searching for 1101
					if (data == 4'b1101) begin
						state <= 4'b0001;
					end else begin
						state <= 4'b0000;
					end
				end
				4'b0001: begin // Shifting in delay[3:0]
					delay <= {data, delay[3:1]};
					state <= 4'b0010;
				end
				4'b0010: begin // Counting
					counting <= 1;
					timer_count <= (delay + 1) * 1000;
					remaining_time <= delay;
					state <= 4'b0011;
				end
				4'b0011: begin // Waiting for count to finish
					if (timer_count == 0) begin
						state <= 4'b0100;
					end else begin
						timer_count <= timer_count - 1;
						if (timer_count % 1000 == 0) begin
							remaining_time <= remaining_time - 1;
						end
						state <= 4'b0011;
					end
				end
				4'b0100: begin // Done
					done <= 1;
					counting <= 0;
					state <= 4'b0101;
				end
				4'b0101: begin // Waiting for ack and reset
					if (ack) begin
						done <= 0;
						state <= 4'b0000;
					end else begin
						state <= 4'b0101;
					end
				end
				default: begin // Default state
					state <= 4'b0000;
				end
			endcase
		end
	end

endmodule
