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
	
	reg [1:0] current_state;
	reg [1:0] next_state;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always @(*)
	begin
		case (current_state)
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
	
	always @(*)
	begin
		case (current_state)
			A: z = 1'b0;
			B: z = 1'b0;
			C: z = 1'b0;
			D: z = 1'b0;
			E: z = 1'b0;
			F: z = 1'b1;
		endcase
	end
	
endmodule
