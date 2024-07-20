module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg prev_bit;
reg start_bit_detected;
reg [7:0] data;
reg stop_bit_detected;
reg done;
	
// define state values
parameter IDLE = 0;
parameter BIT_1 = 1;
parameter BIT_2 = 2;
parameter BIT_3 = 3;
parameter BIT_4 = 4;
parameter BIT_5 = 5;
parameter BIT_6 = 6;
parameter BIT_7 = 7;
parameter BIT_8 = 8;
parameter WAIT_STOP_BIT = 9;
parameter BYTE_RECEIVED = 10;
	
// synchronous reset
always @(posedge clk or posedge reset) begin
	if(reset) begin
		state <= IDLE;
		start_bit_detected <= 0;
		data <= 0;
		stop_bit_detected <= 0;
		done <= 0;
	end else begin
		case(state)
			IDLE: begin
				if (in == 0) begin
					state <= BIT_1;
				end
			end

			BIT_1: begin
				if (prev_bit == 0 && in == 1) begin
					state <= BIT_2;
				end
			end

			BIT_2: begin
				if (prev_bit == 1 && in == 0) begin
					state <= BIT_3;
				end
			end
			
			BIT_3: begin
				if (prev_bit == 0 && in == 1) begin
					state <= BIT_4;
				end
			end

			BIT_4: begin
				if (prev_bit == 1 && in == 0) begin
					state <= BIT_5;
				end
			end
			
			BIT_5: begin
				if (prev_bit == 0 && in == 1) begin
					state <= BIT_6;
				end
			end

			BIT_6: begin
				if (prev_bit == 1 && in == 0) begin
					state <= BIT_7;
				end
			end
			
			BIT_7: begin
				if (prev_bit == 0 && in == 1) begin
					state <= BIT_8;
				end
			end

			BIT_8: begin
				if (prev_bit == 1 && in == 0) begin
					state <= WAIT_STOP_BIT;
				end
			end

			WAIT_STOP_BIT: begin
				if (prev_bit == 0 && in == 1) begin
					state <= BYTE_RECEIVED;
				end
			end
			
			BYTE_RECEIVED: begin
				if (prev_bit == 1 && in == 0) begin
					if (stop_bit_detected) begin
						done <= 1;
					end
					state <= IDLE;
				end
			end
		endcase
	end
end

// detect start bit
always @(posedge clk) begin
	prev_bit <= in;
	if (state == IDLE) begin
		if (in == 0) begin
			start_bit_detected <= 1;
		end else begin
			start_bit_detected <= 0;
		end
	end
end

// detect stop bit
always @(posedge clk) begin
	if (state == BIT_8) begin
		if (in == 1) begin
			stop_bit_detected <= 1;
		end else begin
			stop_bit_detected <= 0;
		end
	end
end

// shift in data bits
always @(posedge clk) begin
	case(state)
		BIT_2, BIT_4, BIT_6, BIT_8: begin
			data <= {data[6:0], in};
		end
		default: begin
			data <= data;
		end
	endcase
end

endmodule
