module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// Define states
parameter IDLE = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BITS = 2'b10;
parameter STOP_BIT = 2'b11;

reg [1:0] state;
reg [7:0] data_byte;
reg start_found;
reg [2:0] bit_counter;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		data_byte <= 8'b0;
		bit_counter <= 3'b0;
		start_found <= 1'b0;
		out_byte <= 8'b0;
		done <= 1'b0;
	else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
					start_found <= 1'b1;
					bit_counter <= 3'b0;
				end
			end
			
			START_BIT: begin
				if (bit_counter < 3'b111) begin
					bit_counter <= bit_counter + 1'b1;
					data_byte[bit_counter] <= in;
				end else begin
					state <= DATA_BITS;
					bit_counter <= 3'b0;
				end
			end
			
			DATA_BITS: begin
				if (bit_counter < 3'b111) begin
					bit_counter <= bit_counter + 1'b1;
					data_byte[bit_counter] <= in;
				end else begin
					state <= STOP_BIT;
					bit_counter <= 3'b0;
				end
			end
			
			STOP_BIT: begin
				if (in == 1'b1) begin
					state <= IDLE;
					out_byte <= data_byte;
					done <= 1'b1;
				end
			end
		endcase
	end
end

endmodule
