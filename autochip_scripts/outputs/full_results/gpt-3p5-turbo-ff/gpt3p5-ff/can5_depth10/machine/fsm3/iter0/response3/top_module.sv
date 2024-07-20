module top_module (
	input clk,
	input in,
	input areset,
	output out
);
// Define the states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the state register
reg [1:0] state;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		// Reset the state to A
		state <= A;
	end else begin
		// Update the state based on the current state and input
		case (state)
			A: begin
				if (in) begin
					// transition from A to B if input is 1
					state <= B;
				end else begin
					// transition from A to A if input is 0
					state <= A;
				end
			end
			B: begin
				if (in) begin
					// transition from B to B if input is 1
					state <= B;
				end else begin
					// transition from B to C if input is 0
					state <= C;
				end
			end
			C: begin
				if (in) begin
					// transition from C to D if input is 1
					state <= D;
				end else begin
					// transition from C to A if input is 0
					state <= A;
				end
			end
			D: begin
				if (in) begin
					// transition from D to B if input is 1
					state <= B;
				end else begin
					// transition from D to C if input is 0
					state <= C;
				end
			end
		endcase
	end
end

// Assign the output
assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
