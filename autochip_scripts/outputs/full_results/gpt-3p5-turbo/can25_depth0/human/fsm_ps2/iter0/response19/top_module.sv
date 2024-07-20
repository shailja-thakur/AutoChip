module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;  // FSM state
reg [7:0] byte1, byte2, byte3;  // Store the current bytes
reg done;  // Flag to indicate when a message is received

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin  // Wait for first byte with in[3] = 1
				if (in[3]) begin
					state <= 1;
					byte1 <= in;
				end
			end
			1: begin  // Receive second byte
				state <= 2;
				byte2 <= in;
			end
			2: begin  // Receive third byte and set done flag
				state <= 0;
				byte3 <= in;
				done <= 1;
			end
		endcase
	end
end

endmodule
