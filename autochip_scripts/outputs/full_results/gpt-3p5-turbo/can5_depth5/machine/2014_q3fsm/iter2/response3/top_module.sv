module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter S10 = 3;
	parameter S11 = 4;
	parameter S20 = 5;
	parameter S21 = 6;
	parameter S22 = 7;
	
	reg [2:0] current_state;
	reg [2:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always @(*) begin
		case (current_state)
			A: begin
				if (s)
					next_state = B;
				else
					next_state = A; // Added else case to stay in state A
			end
			
			B: begin
				if (w)
					next_state = S11;
				else
					next_state = S10;
			end
			
			C: begin
				if (w)
					next_state = S11;
				else
					next_state = S10;
			end
			
			S10: begin
				if (w)
					next_state = S21;
				else if (c)
					next_state = B; // Fixed typo: changed S20 to B
				else
					next_state = S20;
			end
			
			S11: begin
				if (w)
					next_state = S22;
				else
					next_state = S21;
			end
			
			S20: begin
				if (c)
					next_state = B;
				else
					next_state = S21; // Fixed typo: changed S20 to S21
			end
			
			S21: begin
				if (w)
					next_state = B;
				else
					next_state = C;
			end
			
			S22: begin
				if (w)
					next_state = B;
				else
					next_state = C;
			end
		endcase
	end
	
	always @(posedge clk) begin
		if (reset)
			z <= 0;
		else begin
			case (current_state)
				A, B, C, S10, S11, S20, S21, S22: begin
					z <= 1; // Set z to 1 in all states instead of 0
				end
			endcase
		end
	end
endmodule
