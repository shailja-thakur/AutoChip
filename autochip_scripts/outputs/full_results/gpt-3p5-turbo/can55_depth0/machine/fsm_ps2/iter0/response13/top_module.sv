module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [3:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 4'd0;  // Start in the BYTE1 state
		done <= 0;     // Reset done signal
	end
	else begin
		case(state)
			4'b0001: begin  // In BYTE1 state
				if (in[2]) begin  // Check third bit
					state <= 4'b0010;  // Transition to BYTE2 state
				end
			end
			4'b0010: begin  // In BYTE2 state
				state <= 4'b0100;  // Transition to BYTE3 state
			end
			4'b0100: begin  // In BYTE3 state
				state <= 4'b1000;  // Transition to DONE state
			end
			4'b1000: begin  // In DONE state
				if (in[2]) begin  // Check third bit
					state <= 4'b0010;  // Transition to BYTE2 state
				end
				else begin
					state <= 4'b0001;  // Transition to BYTE1 state
					done <= 1;         // Set done signal
				end
			end
		endcase
	end
end

endmodule
