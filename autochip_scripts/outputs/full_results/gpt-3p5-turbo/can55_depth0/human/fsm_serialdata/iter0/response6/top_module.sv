module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] shift_reg;
reg valid;
reg [2:0] bit_counter;

parameter IDLE = 0, START_BIT = 1, DATA_BITS = 2, STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		valid <= 0;
		shift_reg <= 0;
		bit_counter <= 0;
	end
	else begin
		case(state)
			IDLE: begin
				if (in == 0)
					state <= START_BIT;
			end
			
			START_BIT: begin
				state <= DATA_BITS;
				shift_reg <= 0;
				bit_counter <= 0;
			end
			
			DATA_BITS: begin
				shift_reg <= {in, shift_reg[7:1]};
				if (bit_counter == 7)
					state <= STOP_BIT;
				else
					bit_counter <= bit_counter + 1;
			end
			
			STOP_BIT: begin
				if (in == 1)
					state <= IDLE;
				else
					state <= START_BIT;
				
				valid <= 1;
				out_byte <= shift_reg;
			end
		endcase
	end
end

assign done = (state == STOP_BIT);

endmodule
