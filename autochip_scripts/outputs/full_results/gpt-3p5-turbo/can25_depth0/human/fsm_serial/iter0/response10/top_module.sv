module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;
reg [7:0] received_data;
reg [7:0] temp_data;
reg [2:0] bit_counter;

parameter IDLE = 0, START_BIT = 1, DATA_BITS = 2, STOP_BIT = 3;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= IDLE;
	else begin
		case(state)
			IDLE: begin
				if (in == 1'b0)
					state <= START_BIT;
				else
					state <= IDLE;
			end
			
			START_BIT: begin
				if (in == 1'b1) begin
					state <= DATA_BITS;
					bit_counter <= 0;
					temp_data <= 8'b0;
				end
				else
					state <= START_BIT;
			end
			
			DATA_BITS: begin
				if (bit_counter == 7) begin
					state <= STOP_BIT;
					received_data <= temp_data;
				end
				else begin
					state <= DATA_BITS;
					bit_counter <= bit_counter + 1;
					temp_data <= {temp_data[6:0], in};
				end
			end
			
			STOP_BIT: begin
				if (in == 1'b0) begin
					state <= IDLE;
					done <= 1'b1;
				end
				else begin
					state <= STOP_BIT;
					done <= 1'b0;
				end
			end
		endcase
	end
end

endmodule
