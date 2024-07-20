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
	reg done;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			shift_reg <= 8'b0;
			done <= 0;
		end
		else begin
			case(state)
				IDLE:
					if (in == 1'b0)
						state <= START_BIT;
				START_BIT:
					begin
						shift_reg <= 8'b0;
						state <= DATA_BITS;
					end
				DATA_BITS:
					begin
						shift_reg <= {shift_reg[6:0], in};
						if (shift_reg[7] == 1'b1)
							state <= STOP_BIT;
					end
				STOP_BIT:
					begin
						state <= IDLE;
						done <= 1;
					end
			endcase
		end
	end
	
	assign out_byte = shift_reg;
	
endmodule
