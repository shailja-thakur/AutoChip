module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	parameter A = 1'b1;
	parameter B = 1'b0;
	
	reg state;
	reg z_reg;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else begin
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
						state <= A;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		case(state)
			A: z_reg <= 1'b0;
			B: z_reg <= 1'b1;
		endcase
	end
	
	assign z = z_reg;
endmodule
