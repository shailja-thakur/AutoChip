module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	reg [3:0] state;
	reg [7:0] data;
	reg start_bit;
	reg stop_bit;
	
	always@(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			data <= 0;
			start_bit <= 0;
			stop_bit <= 1;
			done <= 0;
		end else begin
			case(state)
				0: begin // IDLE
					if (in == 0) begin
						start_bit <= 1;
						state <= 1; // Move to START_BIT state
					end
				end
				1: begin // START_BIT
					if (in == 1) begin
						start_bit <= 0;
						state <= 2; // Move to DATA state
					end
				end
				2: begin // DATA
					data <= {in, data[7:1]}; // Shift in the received bit
					state <= 3; // Move to PARITY_BIT state
				end
				3: begin // PARITY_BIT
					state <= 4; // Move to STOP_BIT state
				end
				4: begin // STOP_BIT
					if (in == 1) begin
						stop_bit <= 0;
						if (start_bit == 0) begin
							out_byte <= data;
							done <= 1;
						end else begin // Invalid start bit
							start_bit <= 0;
							state <= 0; // Move back to IDLE state
						end
					end
				end
			endcase
		end
	end
endmodule
