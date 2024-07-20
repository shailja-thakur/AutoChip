module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;

	parameter A = 2'b00;
	parameter B = 2'b01;

	always @(posedge clk or posedge areset) begin
		if(areset)
			state <= A;
		else begin
			case(state)
				A: begin
					if(x)
						state <= B;
					else
						state <= A;
				end
				B: begin
					if(x)
						state <= B;
					else
						state <= A;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case(state)
			A: z <= 1'b0;
			B: z <= 1'b1;
		endcase
	end

endmodule
