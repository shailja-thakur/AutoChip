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
	wire start;

	assign start = (shift_reg == 4'b1101) & (state == 2'b00);

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
		end else begin
			case (state)
				2'b00: begin
					shift_reg <= {shift_reg[2:0], data};
					if (start) begin
						state <= 2'b01;
					end
				end
				2'b01: begin
					shift_reg <= {shift_reg[2:0], data};
					state <= 2'b10;
					delay <= shift_reg[3:0];
					timer_count <= (delay + 1) * 1000;
					counter <= timer_count - 1;
				end
				2'b10: begin
					counting <= 1;
					if (counter == 16'd0) begin
						state <= 2'b11;
					end else begin
						counter <= counter - 1;
					end
				end
				2'b11: begin
					if (ack == 1) begin
						done <= 1;
						counting <= 0;
						state <= 2'b00;
					end
				end
			endcase
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
		count <= counting ? delay - (internal_counter / 1000) : 4'b0000;
	end

endmodule
