module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	reg out_reg;
	
	// Moore output
	always @(state)
		begin
			case(state)
				A: out_reg = 1'b0;
				D: out_reg = 1'b1;
				default: out_reg = 1'b0;
			endcase
		end
	
	// State transition
	always @(posedge clk or posedge areset)
		begin
			if(areset)
				state <= A;
			else
				state <= next_state;
		end
	
	// Next state logic
	always @(state, in)
		begin
			case(state)
				A: next_state = (in) ? B : A;
				B: next_state = (in) ? B : C;
				C: next_state = (in) ? D : A;
				D: next_state = (in) ? B : C;
				default: next_state = A;
			endcase
		end
		
	assign out = out_reg;
	
endmodule
