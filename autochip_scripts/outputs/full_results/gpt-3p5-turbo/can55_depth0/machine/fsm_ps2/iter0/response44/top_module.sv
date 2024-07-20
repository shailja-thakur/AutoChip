module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg done
);

reg [1:0] state;

// State definitions
parameter BYTE1 = 0;
parameter BYTE2 = 1;
parameter BYTE3 = 2;
parameter DONE = 3;

// Default reset values
initial begin
	state <= BYTE1;
	done <= 0;
end

// State machine logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
		done <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (in[2]) // Check third bit of input
					state <= BYTE2;
				else
					state <= BYTE1;
			end
			
			BYTE2: begin
				state <= BYTE3;
			end
			
			BYTE3: begin
				state <= DONE;
			end
			
			DONE: begin
				if (in[2]) // Check third bit of input
					state <= BYTE2;
				else
					state <= BYTE1;
			end
		endcase
	end
end

// Assert done signal in DONE state
always @(state) begin
	if (state == DONE)
		done <= 1;
	else
		done <= 0;
end

endmodule
