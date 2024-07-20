module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [3:0] state;
reg start_bit_detected;
reg [7:0] data_bits;
reg stop_bit_detected;

parameter IDLE = 0;
parameter GET_START_BIT = 1;
parameter GET_DATA_BITS = 2;
parameter GET_STOP_BIT = 3;
parameter BYTE_RECEIVED = 4;

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		start_bit_detected <= 0;
		data_bits <= 0;
		stop_bit_detected <= 0;
		done <= 0;
	end else begin
		case (state)
			IDLE: begin
				if (in == 1'b0) begin
					state <= GET_START_BIT;
					start_bit_detected <= 1;
				end
			end
			GET_START_BIT: begin
				state <= GET_DATA_BITS;
				data_bits <= in;
			end
			GET_DATA_BITS: begin
				if (in == 1'b1) begin
					state <= GET_STOP_BIT;
				end else begin
					data_bits <= {in, data_bits[7:1]};
				end
			end
			GET_STOP_BIT: begin
				if (in == 1'b1) begin
					stop_bit_detected <= 1;
					state <= BYTE_RECEIVED;
				end else begin
					state <= IDLE;
					start_bit_detected <= 0;
				end
			end
			BYTE_RECEIVED: begin
				if (start_bit_detected == 0) begin
					state <= IDLE;
					start_bit_detected <= 0;
				end else begin
					if (in == 1'b0) begin
						state <= GET_START_BIT;
						start_bit_detected <= 1;
					end
					done <= 1;
				end
			end
		endcase
	end
end

endmodule
