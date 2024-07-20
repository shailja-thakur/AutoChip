module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
reg start_detected;
reg [7:0] data;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		start_detected <= 0;
		data <= 0;
	end else begin
		case (state)
			0: begin // Idle state - waiting for start bit
				if (in == 0) begin
					state <= 1; // Detected start bit, move to data state
					start_detected <= 1;
					data <= 0;
				end else begin
					state <= 0; // Stay in idle state
				end
			end
			1: begin // Data state - receiving 8 data bits
				if (start_detected) begin
					data <= {in, data[7:1]}; // Shift in received bit
					state <= 2; // Move to stop bit state
				end else begin
					state <= 0; // Start bit not detected, go back to idle state
				end
			end
			2: begin // Stop bit state - verifying stop bit
				if (in == 1) begin
					state <= 0; // Stop bit detected, go back to idle state
					start_detected <= 0;
					done <= 1; // Byte successfully received
				end else begin
					state <= 2; // Stay in stop bit state
				end
			end
		endcase
	end
end

endmodule
