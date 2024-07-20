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
reg [7:0] data;
reg [2:0] bit_counter;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= IDLE;
	else begin
		case (state)
			IDLE: begin
				if (in == 1'b0)
					state <= START_BIT;
			end
			START_BIT: begin
				state <= DATA_BITS;
				data <= 8'b0;
				bit_counter <= 0;
			end
			DATA_BITS: begin
				if (bit_counter < 8) begin
					data[bit_counter] <= in;
					bit_counter <= bit_counter + 1;
				end
				else
					state <= STOP_BIT;
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					done <= 1;
					out_byte <= data;
				end
				else
					state <= START_BIT;
			end
		endcase
	end
end

endmodule
