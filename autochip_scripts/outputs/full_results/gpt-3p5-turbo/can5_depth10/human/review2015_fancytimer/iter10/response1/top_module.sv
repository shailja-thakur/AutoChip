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
			shift_reg <= 0;
			state <= 0;
			counter <= 0;
			timer_count <= 0;
			internal_counter <= 0;
			delay <= 0;
			counting <= 0;
			done <= 0;
		end else begin
			case (state)
				0: begin
					shift_reg <= {data, shift_reg[3:1]};
					if (shift_reg == 4'b1101) begin
						state <= 1;
					end
				end
				1: begin
					shift_reg <= {data, shift_reg[3:1]};
					state <= 2;
					delay <= shift_reg[3:0];
					timer_count <= (delay + 1) * 1000;
					counter <= timer_count - 1;
				end
				2: begin
					counting <= 1;
					if (counter == 0) begin
						state <= 3;
					end else begin
						counter <= counter - 1;
					end
				end
				3: begin
					if (ack == 1) begin
						done <= 1;
						counting <= 0;
						state <= 0;
					end
				end
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			internal_counter <= 0;
		end else begin
			if (counting) begin
				if (internal_counter == 999) begin
					internal_counter <= 0;
				end else begin
					internal_counter <= internal_counter + 1;
				end
			end
		end
	end

	always @(posedge clk) begin
		count <= counting ? delay - (internal_counter / 1000) : 4'b0000;
	end

endmodule
