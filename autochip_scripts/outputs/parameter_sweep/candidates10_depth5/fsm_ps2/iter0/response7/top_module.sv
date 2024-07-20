module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] buffer[2:0]; // Buffer to store the incoming bytes
reg [1:0] state; // FSM state
reg done_internal; // Internal signal to indicate completion of a message

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0; // Reset the FSM state
		buffer <= 0; // Reset the buffer
		done_internal <= 0; // Reset the done signal
	end else begin
		case (state)
			0: begin // Wait for the first byte with in[3]=1
				if (in[3]) begin
					buffer[0] <= in;
					state <= 1;
				end
			end
			1: begin // Wait for the second byte
				buffer[1] <= in;
				state <= 2;
			end
			2: begin // Wait for the third byte
				buffer[2] <= in;
				state <= 0;
				done_internal <= 1;
			end
		endcase
	end
end

assign done = done_internal;

endmodule
