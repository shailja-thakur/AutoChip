module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	enum {A, B} state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else begin
			case (state)
				A: begin
					if (x == 1'b0)
						state <= A;
					else
						state <= B;
				end
				B: begin
					if (x == 1'b0)
						state <= B;
					else
						state <= B;
				end
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			A: z <= 1'b0;
			B: z <= 1'b1;
		endcase
	end
	
endmodule
