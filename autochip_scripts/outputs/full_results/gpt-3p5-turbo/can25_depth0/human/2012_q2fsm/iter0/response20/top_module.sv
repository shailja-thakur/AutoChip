module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State definition
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
  
// State flip-flop
reg [1:0] current_state, next_state;
  
always @(posedge clk, posedge reset)
begin
	if (reset)
		current_state <= A;
	else
		current_state <= next_state;
end
  
// State table
always @*
begin
	case (current_state)
		A: if (w) next_state = B; else next_state = A;
		B: if (w) next_state = C; else next_state = D;
		C: if (w) next_state = E; else next_state = D;
		D: if (w) next_state = F; else next_state = A;
		E: if (z) next_state = E; else next_state = D;
		F: if (z) next_state = C; else next_state = D;
		default: next_state = A;
	endcase
end
  
// FSM output
always @*
begin
	case (current_state)
		E: z = 1'b1;
		default: z = 1'b0;
	endcase
end
  
endmodule
