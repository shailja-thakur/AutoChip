module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg start_bit_found;
reg [7:0] data_counter;
reg stop_bit_found;

parameter IDLE = 0;
parameter CHECK_START_BIT = 1;
parameter RECEIVE_DATA = 2;
parameter CHECK_STOP_BIT = 3;

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		start_bit_found <= 0;
		data_counter <= 0;
		stop_bit_found <= 0;
		done <= 0;
	end else begin
		case (state)
			IDLE:
				if (in == 1'b0) begin
					state <= CHECK_START_BIT;
					data_counter <= 0;
					start_bit_found <= 1;
					stop_bit_found <= 0;
				end else begin
					state <= IDLE;
					start_bit_found <= 0;
					data_counter <= 0;
					stop_bit_found <= 0;
				end
			CHECK_START_BIT:
				if (in == 1'b0) begin
					if (data_counter < 8) begin
						data_counter <= data_counter + 1;
						state <= RECEIVE_DATA;
					end else begin
						state <= CHECK_STOP_BIT;
					end
				end else begin
					state <= IDLE;
					start_bit_found <= 0;
					data_counter <= 0;
					stop_bit_found <= 0;
				end
			RECEIVE_DATA:
				if (in == 1'b0) begin
					if (data_counter < 8) begin
						data_counter <= data_counter + 1;
						state <= RECEIVE_DATA;
					end else begin
						state <= CHECK_STOP_BIT;
					end
				end else begin
					state <= IDLE;
					start_bit_found <= 0;
					data_counter <= 0;
					stop_bit_found <= 0;
				end
			CHECK_STOP_BIT:
				if (in == 1'b1) begin
					state <= IDLE;
					start_bit_found <= 0;
					data_counter <= 0;
					stop_bit_found <= 1;
					done <= 1;
				end else begin
					state <= WAIT_FOR_STOP_BIT;
				end
			WAIT_FOR_STOP_BIT:
				if (in == 1'b1) begin
					state <= IDLE;
					start_bit_found <= 0;
					data_counter <= 0;
					stop_bit_found <= 0;
				end else begin
					state <= WAIT_FOR_STOP_BIT;
				end
		endcase
	end
end

endmodule
