module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	// FSM states
	parameter A = 0;
	parameter B = 1;
	
	// State and next state variables
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Combinational logic to determine next state
	always @* begin
		if (state == A) begin
			if (j == 1'b1)
				next_state = B;
			else
				next_state = A;
		end else begin
			if (k == 1'b1)
				next_state = A;
			else
				next_state = B;
		end
	end
	
	// Clocked always block to update state
	always @(posedge clk or posedge areset) begin
		if (areset == 1'b1)
			state <= A;
		else
			state <= next_state;
	end
	
	// Assign output based on current state
	assign out = (state == B) ? 1'b1 : 1'b0;
	
endmodule
