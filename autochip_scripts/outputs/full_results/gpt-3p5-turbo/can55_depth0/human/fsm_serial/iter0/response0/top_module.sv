module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;
reg start_bit_found;
reg [7:0] data_bits_counter;
reg stop_bit_found;

parameter IDLE = 4'b0000;
parameter START_BIT = 4'b0001;
parameter DATA_BITS = 4'b0010;
parameter STOP_BIT = 4'b0011;

assign done = (state == STOP_BIT && stop_bit_found);

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		start_bit_found <= 0;
		data_bits_counter <= 0;
		stop_bit_found <= 0;
	end else begin
		case(state)
			IDLE:
				if (in == 1'b0)
					state <= START_BIT;
			START_BIT:
				if (in == 1'b0) begin
					state <= DATA_BITS;
					data_bits_counter <= 0;
				end else
					state <= START_BIT;
			DATA_BITS:
				if (data_bits_counter == 7)
					state <= STOP_BIT;
				else if (in == 1'b1)
					state <= START_BIT;
				else
					data_bits_counter <= data_bits_counter + 1;
			STOP_BIT:
				if (in == 1'b1) begin
					stop_bit_found <= 1;
					state <= IDLE;
				end else
					state <= STOP_BIT;
		endcase
	end
end

endmodule
