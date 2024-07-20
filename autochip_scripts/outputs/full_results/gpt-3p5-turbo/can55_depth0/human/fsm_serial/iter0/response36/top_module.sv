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
reg valid_data;
reg done;
	
always @(posedge clk or posedge reset) begin
	if (reset == 1'b1) begin
		state <= 3'b000;
		data <= 8'b0;
		start_bit <= 1'b0;
		stop_bit <= 1'b1;
		valid_data <= 1'b0;
		done <= 1'b0;
	end else begin
		case (state)
			3'b000: begin // Idle state
				if (in == 1'b0) begin
					state <= 3'b001; // Start bit detected
					start_bit <= 1'b1;
				end
			end
			3'b001: begin // Start bit detected
				if (in == 1'b0) begin
					state <= 3'b010; // Receive data bits
					data <= in;
				end else begin
					state <= 3'b000; // Go back to idle state
					start_bit <= 1'b0;
				end
			end
			3'b010: begin // Receive data bits
				if (in == 1'b0) begin
					data <= {data[6:0], in};
				end else begin
					state <= 3'b011; // Stop bit expected
				end
			end
			3'b011: begin // Stop bit expected
				if (in == 1'b1) begin
					if (start_bit == 1'b1 && data == 8'b01011010) begin
						// Data valid
						state <= 3'b100; // Done state
						valid_data <= 1'b1;
						done <= 1'b1;
					end else begin
						// Invalid data
						state <= 3'b000; // Go back to idle state
						valid_data <= 1'b0;
						done <= 1'b0;
					end
					start_bit <= 1'b0;
				end
			end
			3'b100: begin // Done state
				state <= 3'b000; // Go back to idle state
				valid_data <= 1'b0;
				done <= 1'b0;
			end
		endcase
	end
end

endmodule
