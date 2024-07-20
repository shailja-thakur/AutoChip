module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	
	reg [2:0] state;
	reg [7:0] data;
	reg [7:0] data_reg;
	reg start_bit_detected;
	reg stop_bit_detected;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			data <= 8'b0;
			data_reg <= 8'b0;
		end else begin
			case (state)
				0: begin // idle state
					start_bit_detected <= 0;
					stop_bit_detected <= 0;
						
					if (in == 1'b0) begin // check for start bit
						state <= 3'b001;
						data <= 8'b0;
					end
				end
				
				1: begin // receive 8 data bits
					start_bit_detected <= 1;
					stop_bit_detected <= 0;
					data <= {data[6:0], in};
					
					if (in == 1'b1) begin // check for stop bit
						state <= 3'b010;
					end
				end
				
				2: begin // check stop bit
					start_bit_detected <= 1;
					stop_bit_detected <= 1;
						
					if (in == 1'b0) begin
						// incorrect stop bit, wait for next stop bit
						state <= 3'b000;
					end else begin
						// correct stop bit, store received data
						data_reg <= data;
						state <= 3'b011;
					end
				end
					
				3: begin // done state
					done <= 1;
				end
					
				default: state <= 3'b000;
				
			endcase
		end
	end

endmodule
