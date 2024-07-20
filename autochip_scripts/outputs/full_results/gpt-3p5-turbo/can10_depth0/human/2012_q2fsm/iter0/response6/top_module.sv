module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	always @* begin
		next_state = state;
		case (state)
			A: begin
				if (w)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
			
			C: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end
			
			D: begin
				if (w)
					next_state = F;
				else
					next_state = A;
			end
			
			E: begin
				if (z)
					next_state = E;
				else
					next_state = D;
			end
			
			F: begin
				if (z)
					next_state = C;
				else
					next_state = D;
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			A: z = 1'b0;
			E: z = 1'b1;
			default: z = 1'bZ;
		endcase
	end
endmodule
