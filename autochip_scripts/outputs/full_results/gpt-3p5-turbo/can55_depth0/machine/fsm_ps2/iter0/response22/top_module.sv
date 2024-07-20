module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state, next_state;

// State definitions
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

// Assign initial state
initial begin
	state = BYTE1;
end

// Assign next state based on current state and input
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= BYTE1;
	end else begin
		case (state)
			BYTE1: begin
						if (in[2] == 1'b1)
							next_state = BYTE2;
						else
							next_state = BYTE1;
					end
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: begin
						if (in[2] == 1'b0)
							next_state = BYTE1;
						else
							next_state = BYTE2;
					end
		endcase
	end
end

// Update state
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= BYTE1;
	else
		state <= next_state;
end

// Output done signal when in the DONE state
assign done = (state == DONE);

endmodule
