module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	
	reg [1:0] state;
	assign z = (state === C);
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= A;
		else
		begin
			case (state)
				A: if (x)
						state <= C;
					else
						state <= A;
				B: if (x)
						state <= B;
					else
						state <= C;
				C: if (x)
						state <= B;
					else
						state <= C;
				default: state <= A;
			endcase
		end
	end
endmodule
