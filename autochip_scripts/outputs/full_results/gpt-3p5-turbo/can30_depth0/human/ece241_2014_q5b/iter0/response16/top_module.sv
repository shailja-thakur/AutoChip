module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state; 
	reg z_reg;
	
	parameter A = 2'b00;
	parameter B = 2'b01;
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= A;
		else
		begin
			case(state)
				A: begin
					if (x)
						state <= B;
					else
						state <= A;
				end
				
				B: begin
					if (x)
						state <= B;
					else
						state <= B;
				end
			endcase
		end
	end
	
	always @(state, x)
	begin
		case(state)
			A: z_reg = 1'b0;
			B: z_reg = 1'b1;
		endcase
	end
	
	assign z = z_reg;
endmodule
