module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] shift_reg;
	reg [1:0] state;
	reg [15:0] counter;
	reg [15:0] timer_count;
	reg [15:0] internal_counter;
	reg [15:0] delay;
	reg start;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 4'b0000;
			state <= 2'b00;
			counter <= 16'd0;
			timer_count <= 16'd0;
			internal_counter <= 16'd0;
			delay <= 16'd0;
			counting <= 0;
			done <= 0;
			start <= 0;
		end else begin
			start <= (start | (shift_reg == 4'b1101)) & ~counting;
			shift_reg <= {shift_reg[2:0], data};
			if (start) begin
				state <= 2'b01;
				delay <= shift_reg[3:0];
				timer_count <= (delay + 1) * 1000;
				counter <= timer_count - 1;
				counting <= 1;
			end else if (counting) begin
				counter <= counter - 1;
				if (counter == 16'd0) begin
					counting <= 0;
					done <= 1;
				end
			end else if (ack) begin
				state <= 2'b00;
				shift_reg <= 4'b0000;
				internal_counter <= 16'd0;
				done <= 0;
			end
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			internal_counter <= 16'd0;
		end else begin
			if (counting) begin
				internal_counter <= internal_counter + 1;
			end
		end
	end

	always @(posedge clk) begin
		count <= counting ? (delay - (internal_counter / 1000)) : 4'b0000;
	end

endmodule
