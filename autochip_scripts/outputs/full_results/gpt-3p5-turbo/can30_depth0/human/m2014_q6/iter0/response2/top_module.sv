module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	reg [2:0] state;
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;

	always @(posedge clk or posedge reset) begin
		if(reset)
			state <= A;
		else begin
			case(state)
				A: begin
					if(w==0)
						state <= B;
					else
						state <= A;
				end
				B: begin
					if(w==0)
						state <= C;
					else
						state <= D;
				end
				C: begin
					if(w==0)
						state <= E;
					else
						state <= D;
				end
				D: begin
					if(w==0)
						state <= F;
					else
						state <= A;
				end
				E: begin
					if(w==0)
						state <= E;
					else
						state <= D;
				end
				F: begin
					if(w==0)
						state <= C;
					else
						state <= D;
				end
			endcase
		end
	end

	always @(state, w) begin
		case(state)
			A: z = 1'b0;
			B: z = 1'b0;
			C: z = 1'b0;
			D: z = 1'b0;
			E: z = 1'b1;
			F: z = 1'b1;
		endcase
	end
endmodule
