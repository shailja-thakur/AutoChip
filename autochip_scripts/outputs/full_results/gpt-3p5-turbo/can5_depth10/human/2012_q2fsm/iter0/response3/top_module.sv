module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define state codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define internal signals
	reg [1:0] current_state;
	reg [1:0] next_state;
	
	// Combinational logic for next state calculation
	always @*
	begin
		case (current_state)
			A: if (w) next_state = B; else next_state = A;
			B: if (w) next_state = C; else next_state = D;
			C: if (w) next_state = E; else next_state = D;
			D: if (w) next_state = F; else next_state = A;
			E: if (z) next_state = E; else next_state = D;
			F: if (z) next_state = C; else next_state = D;
		endcase
	end
	
	// Synchronous process for current state flip-flop
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	// Output generation
	always @*
	begin
		case (current_state)
			A: z = 0;
			E: z = 1;
			default: z = 0;
		endcase
	end
	
endmodule
