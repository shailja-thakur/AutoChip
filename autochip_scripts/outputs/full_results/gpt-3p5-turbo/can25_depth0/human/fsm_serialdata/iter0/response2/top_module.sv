module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	parameter IDLE = 2'b00;
	parameter START_BIT = 2'b01;
	parameter DATA_BITS = 2'b10;
	parameter STOP_BIT = 2'b11;
	
	reg [1:0] state;
	reg [7:0] shift_reg;
	reg [2:0] bit_counter;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			shift_reg <= 8'b0;
			bit_counter <= 0;
			out_byte <= 8'b0;
			done <= 0;
		end else begin
			case (state)
				IDLE:
					if (in == 0)
						state <= START_BIT;
				START_BIT:
					if (in == 1)
						state <= IDLE;
					else
						state <= DATA_BITS;
				DATA_BITS:
					shift_reg <= {shift_reg[6:0], in};
					if (bit_counter == 7)
						state <= STOP_BIT;
					else
						bit_counter <= bit_counter + 1;
				STOP_BIT:
					if (in == 1) begin
						out_byte <= shift_reg;
						done <= 1;
						state <= IDLE;
						shift_reg <= 8'b0;
						bit_counter <= 0;
					end
					else
						state <= IDLE;
			endcase
		end
	end

endmodule
