module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] data;
reg start_bit_detected;
reg [2:0] bit_counter;

parameter IDLE = 0;
parameter START_BIT = 1;
parameter DATA_BITS = 2;
parameter STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= IDLE;
	else begin
		case (state)
			IDLE: begin
				if (in == 1'b0)
					state <= START_BIT;
				else
					state <= IDLE;
				bit_counter <= 0;
				start_bit_detected <= 0;
			end

			START_BIT: begin
				if (in == 1'b0) begin
					start_bit_detected <= 1;
					state <= DATA_BITS;
					bit_counter <= 0;
				end else
					state <= IDLE;
			end

			DATA_BITS: begin
				if (bit_counter < 8) begin
					data[bit_counter] <= in;
					bit_counter <= bit_counter + 1;
				end else begin
					if (in == 1'b1)
						state <= STOP_BIT;
					else
						state <= IDLE;
				end
			end

			STOP_BIT: begin
				if (in == 1'b1) begin
					out_byte <= data;
					state <= IDLE;
					bit_counter <= 0;
					start_bit_detected <= 0;
					done <= 1;
				end else
					state <= IDLE;
			end
		endcase
	end
end

endmodule
