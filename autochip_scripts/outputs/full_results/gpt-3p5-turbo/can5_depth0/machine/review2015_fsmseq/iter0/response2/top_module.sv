module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);
	
	// Define states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S11 = 2'b10;
	parameter S110 = 2'b11;
	parameter Done = 2'b00;
	
	// Define current state and next state registers
	reg [1:0] state, next_state;
	
	// Assign initial state
	always @(posedge reset)
		state <= S;
	
	// Assign next state based on current state and data input
	always @(posedge clk)
	begin
		case(state)
			S: if (data) next_state <= S1;
			   else next_state <= S;
			   
			S1: if (data) next_state <= S11;
			    else next_state <= S;
			    
			S11: if (data) next_state <= S11;
			     else next_state <= S110;
			     
			S110: if (data) next_state <= Done;
			      else next_state <= S;
			      
			Done: next_state <= Done;
		endcase
	end
	
	// Update state
	always @(posedge clk)
		state <= next_state;
	
	// Assign output based on current state
	always @(state)
	begin
		if (state == Done)
			start_shifting <= 1'b1;
		else
			start_shifting <= 1'b0;
	end
endmodule
