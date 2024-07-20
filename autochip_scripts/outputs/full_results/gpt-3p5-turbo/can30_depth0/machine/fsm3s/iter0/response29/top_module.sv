module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// FSM states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	// Current state register
	reg [1:0] state;

	// Next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A; // Reset state to A
		end else begin
			case (state)
				A: begin
					if (in) begin
						state <= B; // Transition to state B if in=1
					end else begin
						state <= A; // Stay in state A if in=0
					end
				end
				B: begin
					if (in) begin
						state <= B; // Stay in state B if in=1
					end else begin
						state <= C; // Transition to state C if in=0
					end
				end
				C: begin
					if (in) begin
						state <= D; // Transition to state D if in=1
					end else begin
						state <= A; // Transition to state A if in=0
					end
				end
				D: begin
					if (in) begin
						state <= B; // Transition to state B if in=1
					end else begin
						state <= C; // Transition to state C if in=0
					end
				end
			endcase
		end
	end

	// Output logic
	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
