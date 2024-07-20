module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	reg [2:0] state_reg;
	reg [2:0] next_state_reg;
	
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= next_state_reg;
	end
	
	always @*
	begin
		case (state_reg)
			A: begin
				if (w)
					next_state_reg = B;
				else
					next_state_reg = A;
			end
			
			B: begin
				if (w)
					next_state_reg = C;
				else
					next_state_reg = D;
			end
			
			C: begin
				if (w)
					next_state_reg = E;
				else
					next_state_reg = D;
			end
			
			D: begin
				if (w)
					next_state_reg = F;
				else
					next_state_reg = A;
			end
			
			E: begin
				if (z)
					next_state_reg = E;
				else
					next_state_reg = D;
			end
			
			F: begin
				if (z)
					next_state_reg = C;
				else
					next_state_reg = D;
			end
		endcase
	end
	
	assign z = (state_reg == C) ? 1'b1 : 1'b0;
	
endmodule
