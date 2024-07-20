module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// FSM states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	reg out_reg;
	
	// Positive edge-triggered async reset
	always @(posedge clk or areset)
	begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Output generation logic
	always @(state)
	begin
		case(state)
			A: out_reg = 1'b0;
			D: out_reg = 1'b1;
			default: out_reg = 1'b0;
		endcase
	end
	
	// State transition logic
	always @(state, in)
	begin
		case(state)
			A:
			begin
				if (in)
					next_state = B;
				else
					next_state = A;
			end
			
			B:
			begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			
			C:
			begin
				if (in)
					next_state = D;
				else
					next_state = A;
			end
			
			D:
			begin
				if (in)
					next_state = B;
				else
					next_state = C;
			end
			
			default: next_state = A;
		endcase
	end
	
	// Assign output
	assign out = out_reg;
		
endmodule
