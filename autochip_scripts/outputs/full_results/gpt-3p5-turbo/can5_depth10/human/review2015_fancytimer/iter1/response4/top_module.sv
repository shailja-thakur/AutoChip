module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] shift_reg;
	reg [1:0] state;
	reg [12:0] counter;
	reg counting_next;
	reg done_next;
	reg [12:0] delay;
	reg [12:0] remaining_time;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 4'b0000;
			state <= 2'b00;
			counter <= 12'd0;
			counting <= 0;
			done <= 0;
			counting_next <= 0;
			done_next <= 0;
			delay <= 13'd0;
			remaining_time <= 13'd0;
		end else begin
			case (state)
				2'b00: begin
					shift_reg <= {shift_reg[2:0], data};
					if (shift_reg == 4'b1101) begin
						state <= 2'b01;
					end
				end
				2'b01: begin
					shift_reg <= {shift_reg[2:0], data};
					counting_next <= 1;
					state <= 2'b10;
					delay <= shift_reg[3:0];
					counter <= (delay + 1) * 1000;
					remaining_time <= delay;
				end
				2'b10: begin
					counting <= counting_next;
					counter <= counter - 1;
					if (counter == 12'd0) begin
						state <= 2'b11;
					end
					if (remaining_time > 0) begin
						remaining_time <= remaining_time - 1;
					end
				end
				2'b11: begin
					if (ack == 1) begin
						done_next <= 1;
						state <= 2'b00;
					end
				end
			endcase
		end
	end

	assign count = counting ? remaining_time : 4'bxxxx;
	always @(posedge clk) begin
		counting <= counting_next;
		done <= done_next;
	end

endmodule
