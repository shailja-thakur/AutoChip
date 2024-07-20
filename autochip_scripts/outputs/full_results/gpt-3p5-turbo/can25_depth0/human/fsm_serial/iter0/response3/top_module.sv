module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	reg [2:0] state;
	reg [7:0] data;
	reg valid_start;
	reg valid_data;
	reg valid_stop;
	reg done;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000;
			data <= 8'b0;
			valid_start <= 0;
			valid_data <= 0;
			valid_stop <= 0;
			done <= 0;
		end else begin
			case(state)
				3'b000: begin // Idle state
					if (in == 1'b0) begin
						state <= 3'b001; // Start bit detected
						data <= 8'b0;
						valid_start <= 1;
					end else begin
						state <= 3'b000;
						valid_start <= 0;
					end
				end
				3'b001: begin // Receiving data bits
					if (in == 1'b0) begin
						state <= 3'b001;
						data <= {data[6:0], in}; // Shift in received bit
						valid_data <= 1;
					end else begin
						state <= 3'b010; // Stop bit detected
						valid_data <= 0;
					end
				end
				3'b010: begin // Verify stop bit
					if (in == 1'b0) begin
						state <= 3'b010;
						valid_stop <= 0;
					end else begin
						state <= 3'b011; // Transition to next byte
						valid_stop <= 1;
						done <= 1;
					end
				end
				3'b011: begin // Wait for stop bit
					if (in == 1'b0) begin
						state <= 3'b011;
						valid_stop <= 1;
						done <= 0;
					end else begin
						state <= 3'b000; // Return to idle state
						valid_stop <= 0;
					end
				end
			endcase
		end
	end
endmodule
