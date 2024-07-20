module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	reg [2:0] state;
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	
	always @(posedge clk or posedge reset) begin
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
			endcase
		end
	end
	
	always @(posedge clk) begin
		case (state)
			D, E: begin
				z <= 1;
			end
			
			default: begin
				z <= 0;
			end
		endcase
	end
	
endmodule
