module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg start_bit_detected;
reg [7:0] data_bits;
reg stop_bit_detected;

parameter IDLE = 0;
parameter WAIT_START_BIT = 1;
parameter RECEIVE_DATA = 2;
parameter WAIT_STOP_BIT = 3;
parameter BYTE_RECEIVED = 4;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		start_bit_detected <= 0;
		data_bits <= 0;
		stop_bit_detected <= 0;
	end else begin
		case (state)
			IDLE:
				if (in == 1) begin
					start_bit_detected <= 1;
					state <= WAIT_START_BIT;
				end
			WAIT_START_BIT:
				if (in == 0) begin
					start_bit_detected <= 0;
					data_bits <= in;
					state <= RECEIVE_DATA;
				end
			RECEIVE_DATA:
				if (in == 0) begin
					data_bits <= {data_bits[6:0], in};
				end else begin
					state <= WAIT_STOP_BIT;
				end
			WAIT_STOP_BIT:
				if (in == 1) begin
					stop_bit_detected <= 1;
					if (data_bits == 8'd255) begin
						state <= BYTE_RECEIVED;
					end else begin
						state <= IDLE;
					end
				end
			BYTE_RECEIVED:
				if (in == 1) begin
					stop_bit_detected <= 0;
					done <= 1;
					state <= IDLE;
				end
		endcase
	end
end

endmodule
