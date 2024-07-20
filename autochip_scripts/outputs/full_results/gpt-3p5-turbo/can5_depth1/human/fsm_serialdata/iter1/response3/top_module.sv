module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

reg [2:0] state;
reg [7:0] received_byte;
reg [2:0] bit_counter;
reg start_bit_detected;
reg stop_bit_detected;

parameter IDLE = 3'b000;
parameter START_BIT = 3'b001;
parameter DATA_BITS = 3'b010;
parameter STOP_BIT = 3'b011;
parameter BYTE_DONE = 3'b100;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		received_byte <= 8'bz;
		bit_counter <= 3'b000;
		start_bit_detected <= 0;
		stop_bit_detected <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= START_BIT;
				end
			end
			START_BIT: begin
				if (in == 1'b0) begin
					state <= DATA_BITS;
					received_byte <= 8'bz;
					bit_counter <= 3'b000;
					start_bit_detected <= 1;
				end else begin
					state <= IDLE;
				end
			end
			DATA_BITS: begin
				if (bit_counter == 3'b100) begin
					state <= STOP_BIT;
				end else begin
					bit_counter <= bit_counter + 1;
					received_byte <= {received_byte[6:0], in};
				end
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					state <= BYTE_DONE;
					bit_counter <= 3'b000;
					stop_bit_detected <= 1;
				end else begin
					state <= IDLE;
				end
			end
			BYTE_DONE: begin
				if (in == 1'b1) begin
					state <= IDLE;
				end
			end
		endcase
	end
end

assign out_byte = received_byte;
assign done = (state == BYTE_DONE);

endmodule
