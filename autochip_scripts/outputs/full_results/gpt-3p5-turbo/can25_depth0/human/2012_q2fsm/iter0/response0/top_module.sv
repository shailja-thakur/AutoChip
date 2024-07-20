module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State Encoding
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
 
reg [1:0] state_reg, state_next;
 
always @(posedge clk, posedge reset) begin
	if(reset)
		state_reg <= A;
	else
		state_reg <= state_next;
end
 
always @(state_reg, w) begin
	case(state_reg)
		A: begin
			if(w)
				state_next = B;
			else
				state_next = A;
		end
		
		B: begin
			if(w)
				state_next = C;
			else
				state_next = D;
		end
		
		C: begin
			if(w)
				state_next = E;
			else
				state_next = D;
		end
		
		D: begin
			if(w)
				state_next = F;
			else
				state_next = A;
		end
		
		E: begin
			if(w)
				state_next = E;
			else
				state_next = D;
		end
		
		F: begin
			if(w)
				state_next = C;
			else
				state_next = D;
		end
	endcase
end
 
// FSM Output
always @(state_reg) begin
	case(state_reg)
		E: z <= 1;
		default: z <= 0;
	endcase
end

endmodule
