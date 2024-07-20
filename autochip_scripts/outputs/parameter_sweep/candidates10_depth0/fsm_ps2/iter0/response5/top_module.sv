module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] byte_counter;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte_counter <= 0;
	end else begin
		case (state)
			0: begin // Idle state
				if (in[3]) begin
					state <= 1; // Start receiving message
					byte_counter <= 1;
				end
			end
			1: begin // Receiving a message
				if (byte_counter < 3) begin
					byte_counter <= byte_counter + 1;
				end else begin
					byte_counter <= 0;
					state <= 2; // Message received
				end
			end
			2: begin // Message received
				state <= 0; // Go back to idle state
			end
		endcase
	end
end

assign done = (state == 2);

endmodule
