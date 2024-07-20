module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

// State encoding
parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
reg [1:0] state, next_state;

// State transition logic
always @(*) begin
	case (state)
		A: begin
			if (r[1] == 1) next_state = B;
			else if (r[2] == 1) next_state = C;
			else if (r[3] == 1) next_state = D;
			else next_state = A;
		end
		B: begin
			if (r[1] == 1) next_state = B;  // Remain in B while r1 is 1
			else next_state = A;            // Go back to A if r1 is 0
		end
		C: begin
			if (r[2] == 1) next_state = C;  // Remain in C while r2 is 1
			else next_state = A;            // Go back to A if r2 is 0
		end
		D: next_state = A; // Return to A from state D (D acts as a 'bypass' state for r3)
		default: next_state = A; // Default to state A on invalid state
	endcase
end

// State flip-flops
always @(posedge clk) begin
	if (!resetn)
		state <= A; // Reset state to A on resetn
	else
		state <= next_state;
end

// Output logic
always @(*) begin
	case (state)
		A: g = 3'b000;
		B: g = 3'b001; // Device 1 gets grant
		C: g = 3'b010; // Device 2 gets grant
		D: g = 3'b100; // Device 3 gets grant
		default: g = 3'b000;
	endcase
end

endmodule
