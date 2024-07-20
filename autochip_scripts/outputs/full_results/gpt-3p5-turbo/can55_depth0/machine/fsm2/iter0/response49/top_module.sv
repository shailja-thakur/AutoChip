module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// Define states
	typedef enum logic [1:0] {A, B} state_type;
	state_type current_state, next_state;
	
	// Combinational always block
	always_comb begin
		case (current_state)
			A: next_state = (j) ? B : A;
			B: next_state = (k) ? A : B;
		endcase
	end
	
	// Clocked always block
	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Output assignment
	assign out = (current_state == B) ? 1'b1 : 1'b0;
	
endmodule
