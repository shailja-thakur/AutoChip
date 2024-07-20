module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

	// State declarations
	typedef enum reg [0:0] {
		A = 1'b0, 
		B = 1'b1
	} state_t;
	
	state_t current_state, next_state;
	
	// Combinational logic to determine the next state
	always @* begin
		case (current_state)
			A: next_state = j ? B : A;
			B: next_state = k ? A : B;
		endcase
	end
	
	// Sequential logic to update the current state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// Output logic
	always @* begin
		if (current_state == B) begin
			out = 1'b1;
		end else begin
			out = 1'b0;
		end
	end

endmodule
