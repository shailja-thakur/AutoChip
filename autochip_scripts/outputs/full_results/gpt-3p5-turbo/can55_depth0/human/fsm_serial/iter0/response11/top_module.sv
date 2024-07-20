module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	reg [2:0] state;
	reg [7:0] data;
	reg start_bit;
	reg stop_bit;
	reg [2:0] count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			data <= 0;
			start_bit <= 0;
			stop_bit <= 0;
			count <= 0;
		end else begin
			case (state)
				0: begin
					// Wait for start bit
					if (in == 0) begin
						start_bit <= 1;
						count <= count + 1;
						state <= state + 1;
					end
				end
				1 to 8: begin
					// Receive data bits
					data[count-1] <= in;
					count <= count + 1;
					state <= state + 1;
				end
				9: begin
					// Receive stop bit
					if (in == 1) begin
						stop_bit <= 1;
						state <= state + 1;
					end
				end
				10: begin
					// Check if byte received correctly
					if (start_bit && stop_bit) begin
						state <= 0;
						done <= 1;
					end else begin
						state <= 9;
						done <= 0;
					end
				end
				default: begin
					// Should never happen
					state <= 0;
					done <= 0;
				end
			endcase
		end
	end

endmodule
