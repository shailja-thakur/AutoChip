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
	reg [15:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 4'b0000;
			state <= 2'b00;
			counter <= 16'd0;
			counting <= 0;
			done <= 0;
		end else begin
			case (state)
				2'b00: begin
					if (data == 1'b1) begin
						shift_reg <= {shift_reg[2:0], data};
						if (shift_reg == 4'b1101) begin
							state <= 2'b01;
						end
					end
				end
				2'b01: begin
					shift_reg <= {shift_reg[2:0], data};
					state <= 2'b10;
					counter <= (shift_reg[3:0] + 1) * 1000 - 1;
				end
				2'b10: begin
					if (counter != 0) begin
						counting <= 1;
						counter <= counter - 1;
					end else begin
						counting <= 0;
						state <= 2'b11;
					end
				end
				2'b11: begin
					done <= 0;
					counting <= 0;
					if (ack == 1) begin
						done <= 1;
						state <= 2'b00;
					end
				end
			endcase
		end
	end

	assign count = counting ? shift_reg[3:0] : 4'bxxxx;

endmodule
