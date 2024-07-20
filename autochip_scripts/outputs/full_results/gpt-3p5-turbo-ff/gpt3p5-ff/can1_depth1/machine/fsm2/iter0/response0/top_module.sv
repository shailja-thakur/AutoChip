module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	// Define states
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	// Define next state
	reg next_state;
	
	// Define current state
	reg state;
	
	// State transition logic
	always @(*)
	begin
		if(state == A)
		begin
			if(j)
				next_state = B;
			else
				next_state = A;
		end
		else if(state == B)
		begin
			if(k)
				next_state = A;
			else
				next_state = B;
		end
	end
	
	// State update logic
	always @(posedge clk or posedge areset)
	begin
		if(areset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Output logic
	assign out = (state == B) ? 1'b1 : 1'b0;
endmodule
