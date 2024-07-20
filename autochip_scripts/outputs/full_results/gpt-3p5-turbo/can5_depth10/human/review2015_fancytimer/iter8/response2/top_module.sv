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
	reg [17:0] counter;
	reg [17:0] timer_count;
	reg [17:0] internal_counter;
	reg [3:0] delay;
	wire start;

	assign start = (shift_reg == 4'b1101) && (state == 2'b00);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 4'b0000;
			state <= 2'b00;
			counter <= 18'd0;
			timer_count <= 18'd0;
			internal_counter <= 18'd0;
			delay <= 4'd0;
			counting <= 1'b0;
			done <= 1'b0;
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
					counting <= 1'b1;
					counter <= counter - 1;
					if (counter == 18'd0) begin
						state <= 2'b11;
					end
				end
				2'b11: begin
					if (ack == 1'b1) begin
						done <= 1'b1;
						counting <= 1'b0;
						state <= 2'b00;
						shift_reg <= 4'b0000;
						internal_counter <= 18'd0;
					end
				end
			endcase
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			internal_counter <= 18'd0;
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
