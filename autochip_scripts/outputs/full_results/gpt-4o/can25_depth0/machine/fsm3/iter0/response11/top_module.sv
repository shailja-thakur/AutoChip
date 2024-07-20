module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Declare state encoding
	localparam A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	// State register
	reg [1:0] state, next_state;
	
	// Combinational logic for next state
	always @(*) begin
		case (state)
			A: next_state = in ? B : A;
			B: next_state = in ? B : C;
			C: next_state = in ? D : A;
			D: next_state = in ? B : C;
			default: next_state = A; // Default case for safety
		endcase
	end
	
	// Sequential logic for state update
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Output logic
	assign out = (state == D);

endmodule
