module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] received_byte; // Store the current received byte
reg done; // Flag to indicate the end of a message

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		received_byte <= 0;
		done <= 0;
	end
	else begin
		case (state)
			0: begin // Wait for the first byte of a message
				if (in[3] == 1) begin
					received_byte <= in;
					state <= 1;
				end
			end
			1: begin // Wait for the second byte of a message
				received_byte <= in;
				state <= 2;
			end
			2: begin // Wait for the third byte of a message
				received_byte <= in;
				state <= 0;
				done <= 1;
			end
			default: begin
				state <= 0;
				received_byte <= 0;
				done <= 0;
			end
		endcase
	end
end

endmodule
