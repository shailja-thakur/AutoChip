module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State Declarations using one-hot encoding
	reg [1:0] state, next_state;
	localparam A = 2'b01;
	localparam B = 2'b10;

	// State Transition
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= A; // reset to state A
		else
			state <= next_state;
	end

	// Next State Logic
	always @(*) begin
		case (state)
			A: if (x) 
				next_state = B;
			   else 
				next_state = A;
			B: next_state = B; // B remains B regardless of x
			default: next_state = A; // Should never happen
		endcase
	end

	// Output Logic
	always @(*) begin
		case (state)
			A: if (x) 
				z = 1;
			   else 
				z = 0;
			B: if (x) 
				z = 0;
			   else 
				z = 1;
			default: z = 0; // Should never happen
		endcase
	end
endmodule
