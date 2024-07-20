module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] shift_reg;
reg start_bit_detected;
reg [6:0] bit_count;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;
parameter WAIT_FOR_STOP = 3'b100;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		shift_reg <= 8'b0;
		start_bit_detected <= 1'b0;
		bit_count <= 7'b0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					start_bit_detected <= 1'b1;
					state <= START_BIT;
				end
			end
			START_BIT: begin
				if (start_bit_detected) begin
					start_bit_detected <= 1'b0;
					state <= DATA_BITS;
				end
			end
			DATA_BITS: begin
				if (bit_count < 7) begin
					shift_reg <= {shift_reg[6:0], in};
					bit_count <= bit_count + 7'b1;
				end else begin
					state <= STOP_BIT;
				end
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					out_byte <= shift_reg;
					state <= WAIT_FOR_STOP;
				end else begin
					state <= START_BIT;
				end
			end
			WAIT_FOR_STOP: begin
				if (in == 1'b1) begin
					done <= 1'b1;
					state <= IDLE;
				end
			end
		endcase
	end
end
endmodule
