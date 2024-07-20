module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;

	reg [2:0] state;
	
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= A;
		else begin
			case (state)
				A: begin
					if (x)
						state <= B;
					else
						state <= A;
				end
				B: begin
					if (x)
						state <= E;
					else
						state <= B;
				end
				C: begin
					if (x)
						state <= B;
					else
						state <= C;
				end
				D: begin
					if (x)
						state <= C;
					else
						state <= B;
				end
				E: begin
					if (x)
						state <= E;
					else
						state <= D;
				end
				default: state <= A;
			endcase
		end
	end
	
	always @(state) begin
		if (state == D || state == E)
			z <= 1;
		else
			z <= 0;
	end
endmodule
