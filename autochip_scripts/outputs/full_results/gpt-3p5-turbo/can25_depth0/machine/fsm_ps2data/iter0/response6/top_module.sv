module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [1:0] state = 2'b00;  // Initialize state to BYTE1

always @(posedge clk or posedge reset) begin
	if(reset)
		state <= 2'b00;  // Reset state to BYTE1
	else begin
		case(state)
			2'b00: begin  // BYTE1 state
				if(in[2])  // Transition to BYTE2 if third bit is 1
					state <= 2'b01;
				else
					state <= 2'b00;  // Stay in BYTE1 if third bit is 0
			end
			2'b01: begin  // BYTE2 state
				state <= 2'b10;  // Transition to BYTE3
			end
			2'b10: begin  // BYTE3 state
				state <= 2'b11;  // Transition to DONE
			end
			2'b11: begin  // DONE state
				if(in[2])  // Transition to BYTE1 if third bit is 1
					state <= 2'b00;
				else
					state <= 2'b01;  // Transition to BYTE2 if third bit is 0
			end
		endcase
	end
end

always @(posedge clk) begin
	if(done)
		out_bytes <= out_bytes;  // Don't update out_bytes if done signal is set
	else
		out_bytes <= {out_bytes[15:0], in};  // Shift in input and shift left by 8 bits
end

assign done = (state == 2'b11);  // Set done signal to 1 when in the DONE state

endmodule
