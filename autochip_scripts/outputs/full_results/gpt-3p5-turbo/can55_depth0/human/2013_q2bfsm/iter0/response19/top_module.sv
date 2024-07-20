module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
		
	reg [1:0] state, next_state;
	reg f_reg, g_reg;
	parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
	
	always @(posedge clk or negedge resetn) begin
		if(~resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			A: begin
				if (~resetn)
					next_state = A;
				else if (x == 1'b1 && y == 1'b0)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				next_state = C;
				f_reg = 1'b1;
			end
			
			C: begin
				if (x == 1'b0)
					next_state = D;
				else
					next_state = C;
					
				if (y == 1'b1)
					g_reg = 1'b1;
			end
			
			D: begin
				if (y == 1'b0)
					next_state = A;
				else
					next_state = D;
					
				g_reg = 1'b0;
			end
		endcase
	end
	
	always @(posedge clk) begin
		f <= f_reg;
		g <= g_reg;
	end
	
endmodule
