module top_module(
	input wire clk,
	input wire reset,
	input wire data,
	output wire [3:0] count,
	output reg counting,
	output reg done,
	input wire ack
);

	reg [3:0] shift_reg;
	reg [2:0] state;
	reg [15:0] counter;
	reg [15:0] timer_count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 4'b0000;
			state <= 3'b000;
			counter <= 16'd0;
			timer_count <= 16'd0;
			counting <= 0;
			done <= 0;
		end else begin
			case (state)
				3'b000: begin
					shift_reg <= {shift_reg[2:0], data};
					if (shift_reg == 4'b1101) begin
						state <= 3'b001;
					end
				end
				3'b001: begin
					shift_reg <= {shift_reg[2:0], data};
					state <= 3'b010;
					timer_count <= (shift_reg[3:0] + 1) * 1000;
					counter <= timer_count - 1;
				end
				3'b010: begin
					counting <= 1;
					counter <= counter - 1;
					if (counter == 16'd0) begin
						state <= 3'b011;
					end
				end
				3'b011: begin
					if (ack == 1) begin
						done <= 1;
						counting <= 0;
						state <= 3'b000;
						shift_reg <= 4'b0000;
					end
				end
			endcase
		end
	end

	assign count = counting ? counter[11:8] : shift_reg[3:0];

endmodule
