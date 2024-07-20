module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	reg out_reg;
	
	parameter B = 2'b00;
	parameter A = 2'b01;
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= B;
		else
		begin
			case (state)
				B: begin
					if (in)
						state <= B;
					else
						state <= A;
				end
				A: begin
					if (in)
						state <= A;
					else
						state <= B;
				end
			endcase
		end
	end
	
	always @(state)
	begin
		case (state)
			B: out_reg <= 1'b1;
			A: out_reg <= 1'b0;
		endcase
	end
	
	assign out = out_reg;
	
endmodule
