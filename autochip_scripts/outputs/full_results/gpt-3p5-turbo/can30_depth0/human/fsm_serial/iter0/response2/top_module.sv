module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [2:0] state;
wire start_bit;
wire stop_bit;

reg [7:0] data;
reg [2:0] bit_count;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		data <= 0;
		bit_count <= 0;
	end else begin
		case (state)
			0: begin  // Idle state
				if (in == 1'b0) begin  // Start bit detection
					state <= 1;
					bit_count <= 0;
				end
			end
			1: begin  // Data state
				if (bit_count == 8) begin  // All data bits received
					state <= 2;
					bit_count <= 0;
				end else if (in == 1'b0) begin
					data[bit_count] <= in;  // Store data bit
					bit_count <= bit_count + 1;
				end
			end
			2: begin  // Stop bit state
				if (in == 1'b1) begin  // Stop bit detected
					state <= 0;  // Return to idle state
					done <= 1;  // Byte received successfully
				end
			end
		endcase
	end
end

assign start_bit = state == 1;
assign stop_bit = state == 2;

endmodule
