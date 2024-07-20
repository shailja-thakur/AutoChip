module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [1:0] state;
reg [7:0] byte_count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
		byte_count <= 8'b0;
		done <= 1'b0;
	end else begin
		case (state)
			0: begin // Idle state
				if (in[3] == 1'b1) begin
					state <= 1; // Byte 1 received
					byte_count <= 1;
				end
			end
			1: begin // Receiving bytes 2 and 3
				byte_count <= byte_count + 1;
				if (byte_count == 8) begin
					if (in[3] == 1'b1) begin
						state <= 2; // Message received
						done <= 1'b1;
					end else begin
						state <= 0; // Reset state
						done <= 1'b0;
					end
				end
			end
			2: begin // Wait for next message
				state <= 0;
				done <= 1'b0;
			end
		endcase
	end
end

endmodule
