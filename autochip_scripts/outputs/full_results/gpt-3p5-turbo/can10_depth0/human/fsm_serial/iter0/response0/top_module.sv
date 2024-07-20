module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	reg [2:0] state;
	reg start_bit;
	reg [6:0] data;
	reg stop_bit;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			start_bit <= 0;
			data <= 0;
			stop_bit <= 0;
		end else begin
			case (state)
				0: begin // Idle state
					if (in == 1'b0) begin
						state <= 1; // Start bit detected
						start_bit <= 1;
					end
				end
				1: begin // Receive data bits
					state <= 2;
					data[0] <= in;
				end
				2: begin // Receive data bits
					state <= 3;
					data[1] <= in;
				end
				3: begin // Receive data bits
					state <= 4;
					data[2] <= in;
				end
				4: begin // Receive data bits
					state <= 5;
					data[3] <= in;
				end
				5: begin // Receive data bits
					state <= 6;
					data[4] <= in;
				end
				6: begin // Receive data bits
					state <= 7;
					data[5] <= in;
				end
				7: begin // Receive data bits
					state <= 8;
					data[6] <= in;
				end
				8: begin // Receive data bits
					state <= 9;
					data[7] <= in;
				end
				9: begin // Verify stop bit
					state <= 10;
					stop_bit <= in;
				end
				10: begin // Wait for stop bit
					if (in == 1'b1) begin
						state <= 0; // Byte received successfully
						done <= 1;
					end
				end
				default: begin
					state <= 0; // Reset state
				end
			endcase
		end
	end
	
endmodule
