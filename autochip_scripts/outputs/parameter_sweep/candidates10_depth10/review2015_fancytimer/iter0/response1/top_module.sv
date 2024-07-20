module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output wire [3:0] count,
	output reg counting,
	output reg done,
	input wire ack );

	reg [3:0] delay;
	reg [3:0] remaining_time;
	reg [3:0] shift_reg;
	reg [3:0] shift_count;
	reg searching, counting;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			searching <= 1'b1;
			count[3:0] <= 4'b0;
			done <= 1'b0;
		end else begin
			if (searching) begin
				if (data == 4'b1101) begin
					delay <= shift_reg;
					shift_reg <= 4'b0;
					shift_count <= 4'b0;
					searching <= 1'b0;
					counting <= 1'b1;
					remaining_time <= delay;
				end else begin
					shift_reg <= {shift_reg[2:0], data};
					shift_count <= shift_count + 4'b1;
				end
			end else if (counting) begin
				if (shift_count >= delay) begin
					remaining_time <= remaining_time - 4'b1;
					count[3:0] <= remaining_time;
					if (remaining_time == 4'b0) begin
						counting <= 1'b0;
						done <= 1'b1;
					end
				end
			end
			
			if (done && ack) begin
				searching <= 1'b1;
				done <= 1'b0;
			end
		end
	end
endmodule
