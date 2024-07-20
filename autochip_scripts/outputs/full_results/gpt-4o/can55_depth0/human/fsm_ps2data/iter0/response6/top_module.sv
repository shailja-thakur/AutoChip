module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] buffer;

	// State definitions
	localparam IDLE = 2'd0;
	localparam BYTE1 = 2'd1;
	localparam BYTE2 = 2'd2;
	localparam DONE = 2'd3;

	// State transition logic
	always @(posedge clk) begin
		if (reset) 
			state <= IDLE;
		else 
			state <= next_state;
	end

	// Next state logic and output buffer
	always @(*) begin
		next_state = state; // Default to hold state
		done = 1'b0;
		case (state)
			IDLE: begin
				// Wait for in[3] to be 1 and then start capturing bytes
				if (in[3] == 1)
					next_state = BYTE1;
			end
			BYTE1: begin
				// Capture the first byte
				buffer[23:16] = in;
				next_state = BYTE2;
			end
			BYTE2: begin
				// Capture the second byte
				buffer[15:8] = in;
				next_state = DONE;
			end
			DONE: begin
				// Capture the third byte and signal done
				buffer[7:0] = in;
				done = 1'b1;
				next_state = IDLE;
			end
		endcase
	end

	// Output assignment
	always @(posedge clk) begin
		if (state == DONE)
			out_bytes <= buffer;
		else
			out_bytes <= 24'bx; // Don't care value
	end

endmodule
