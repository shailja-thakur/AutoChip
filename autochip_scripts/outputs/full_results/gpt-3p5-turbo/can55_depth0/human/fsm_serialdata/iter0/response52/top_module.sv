module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	
	reg [2:0] state;
	reg [7:0] data_reg;
	reg start_bit_detected;
	reg stop_bit_detected;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			data_reg <= 0;
			start_bit_detected <= 0;
			stop_bit_detected <= 0;
		end else begin
			case (state)
				0: begin // Idle state
					if (in == 1) begin
						state <= 1; // Move to start bit detection state
						start_bit_detected <= 0;
					end
				end
				1: begin // Start bit detection state
					if (in == 0) begin
						state <= 2; // Move to data bits reception state
						data_reg <= 0;
						start_bit_detected <= 1;
					end else if (in == 1) begin
						state <= 1; // Stay in start bit detection state
						start_bit_detected <= 0;
					end
				end
				2: begin // Data bits reception state
					if (in == 0) begin
						state <= 2; // Stay in data bits reception state
						data_reg <= {data_reg[6:0], in};
					end else if (in == 1) begin
						state <= 3; // Move to stop bit detection state
					end
				end
				3: begin // Stop bit detection state
					if (in == 1) begin
						if (start_bit_detected) begin
							state <= 4; // Move to done state
							stop_bit_detected <= 1;
						end else begin
							state <= 0; // Move to idle state
						end
					end
				end
				4: begin // Done state
					state <= 0; // Move to idle state
					stop_bit_detected <= 0;
				end
				default: state <= 0;
			endcase
		end
	end

	assign out_byte = data_reg;
	assign done = (state == 4) ? 1 : 0;

endmodule
