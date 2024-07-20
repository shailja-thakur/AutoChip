module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	// Internal signals
	reg [3:0] delay;
	reg [3:0] count_reg;
	reg [3:0] remaining_time;
	reg start_detected;
	reg searching;
	reg [3:0] state;
	reg [1:0] count_enable;

	// Constants
	parameter IDLE = 4'b0000;
	parameter START_DETECT = 4'b0001;
	parameter SHIFT_IN = 4'b0010;
	parameter COUNT = 4'b0011;
	parameter WAIT_ACK = 4'b0100;
	
	always @(posedge clk) begin
		if (reset) begin
			searching <= 1'b1;
			count_reg <= 4'b0000;
			delay <= 4'b0000;
			count_enable <= 2'b00;
			counting <= 1'b0;
			done <= 1'b0;
			remaining_time <= 4'b0000;
			state <= IDLE;
		end else begin
			case (state)
				IDLE:
					if (data == 1'b1 && start_detected == 1'b0) begin
						start_detected <= 1'b1;
						state <= START_DETECT;
					end else begin
						start_detected <= 1'b0;
						state <= IDLE;
					end
				START_DETECT:
					if (data == 1'b1 && start_detected == 1'b1) begin
						state <= SHIFT_IN;
					end else begin
						start_detected <= 1'b0;
						state <= IDLE;
					end
				SHIFT_IN:
					if (start_detected == 1'b1) begin
						delay <= {delay[2:0], data};
						state <= COUNT;
					end else begin
						state <= IDLE;
					end
				COUNT:
					if (count_enable == 2'b11) begin
						counting <= 1'b0;
						state <= WAIT_ACK;
					end else if (count_reg == delay) begin
						count_enable <= 2'b11;
						state <= COUNT;
					end else begin
						count_reg <= count_reg + 1'b1;
						counting <= 1'b1;
						state <= COUNT;
					end
				WAIT_ACK:
					if (ack == 1'b1) begin
						done <= 1'b1;
						counting <= 1'b0;
						count_enable <= 2'b00;
						state <= IDLE;
					end else begin
						state <= WAIT_ACK;
					end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset) begin
			remaining_time <= 4'b0000;
			count_enable <= 2'b00;
		end else begin
			case (count_enable)
				2'b00:
					remaining_time <= delay;
				2'b01:
					remaining_time <= delay - 1'b1;
				2'b10:
					remaining_time <= delay - 2'b10;
				2'b11:
					remaining_time <= delay - 2'b11;
			endcase
		end
	end
	
	assign count = count_reg;
endmodule
