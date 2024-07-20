module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

	reg [3:0] delay;
	reg [1:0] state;
	reg [15:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			delay <= 4'b0000;
			state <= 2'b00;
			counter <= 16'd0;
			counting <= 0;
			done <= 0;
		end else begin
			case (state)
				2'b00: begin
					if (data == 1'b1) begin
						delay <= data;
						state <= 2'b01;
					end
				end
				2'b01: begin
					delay <= {delay[2:0], data};
					state <= 2'b10;
					counting <= 1;
					counter <= (delay + 1) * 1000 - 1;
				end
				2'b10: begin
					if (counter == 16'd0) begin
						state <= 2'b11;
						counting <= 0;
					end else begin
						counter <= counter - 1;
					end
				end
				2'b11: begin
					if (ack == 1) begin
						done <= 1;
						state <= 2'b00;
					end
				end
			endcase
		end
	end

	assign count = counting ? delay : 4'bxxxx;

endmodule
