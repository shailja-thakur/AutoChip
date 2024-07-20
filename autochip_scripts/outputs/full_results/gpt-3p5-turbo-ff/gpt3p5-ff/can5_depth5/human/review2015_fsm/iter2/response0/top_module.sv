module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

	parameter WAIT_FOR_START = 2'b00;
	parameter SHIFT_ENABLE = 2'b01;
	parameter WAIT_FOR_DONE = 2'b10;
	parameter DONE_AND_WAIT = 2'b11;

	reg [1:0] state;
	reg [3:0] count;
	reg start_detected;
	reg start_detected_reg;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= WAIT_FOR_START;
		end else begin
			case (state)
				WAIT_FOR_START: begin
					if (data == 4'b1101) begin
						state <= SHIFT_ENABLE;
						shift_ena <= 1;
						count <= 0;
						start_detected <= 1;
					end
				end
				SHIFT_ENABLE: begin
					state <= WAIT_FOR_DONE;
					shift_ena <= 0;
					count <= data;
				end
				WAIT_FOR_DONE: begin
					if (done_counting) begin
						state <= DONE_AND_WAIT;
						done <= 1;
					end
				end
				DONE_AND_WAIT: begin
					if (ack) begin
						state <= WAIT_FOR_START;
						done <= 0;
						start_detected <= 0;
					end
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		if (reset) begin
			start_detected_reg <= 0;
		end else begin
			start_detected_reg <= start_detected;
		end
	end

	always @(posedge clk) begin
		if (reset) begin
			counting <= 0;
		end else begin
			if (state == SHIFT_ENABLE && start_detected_reg) begin
				counting <= 1;
			end else if (state == DONE_AND_WAIT && done) begin
				counting <= 0;
			end
		end
	end

endmodule
