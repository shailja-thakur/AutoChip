module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state, next_state;

// Define state encodings
parameter OFF = 2'b00;
parameter ON = 2'b01;

// Output logic
assign out = (state == ON) ? 1'b1 : 1'b0;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		// Synchronous reset
		state <= OFF;
	end else begin
		// State transitions based on inputs
		case (state)
			OFF: begin
				if (j) begin
					next_state <= ON;
				end else begin
					next_state <= OFF;
				end
			end
			ON: begin
				if (!k) begin
					next_state <= ON;
				end else begin
					next_state <= OFF;
				end
			end
		endcase
	end
end

// Assign next_state to state at each clock edge
always @(posedge clk) begin
	state <= next_state;
end

endmodule
