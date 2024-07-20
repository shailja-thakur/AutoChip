module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	parameter A = 2'b00;     // Define state A
	parameter B = 2'b01;     // Define state B
	
	reg [1:0] state;         // Register to store the state
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= A;     // Set state to A when areset is asserted
		else
		begin
			case (state)
				A: state <= (x) ? B : A;     // Transition to state B if x is 1, otherwise stay in state A
				B: state <= B;               // Stay in state B
			endcase
		end
	end
	
	// Output logic
	assign z = ((state == A) && (x)) || ((state == B) && (~x));
endmodule
