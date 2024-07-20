module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else begin
			case(state)
				A: begin
						case(w)
							0: state <= B;
							1: state <= A;
						endcase
					end
					
				B: begin
						case(w)
							0: state <= C;
							1: state <= D;
						endcase
					end
					
				C: begin
						case(w)
							0: state <= E;
							1: state <= D;
						endcase
					end
					
				D: begin
						case(w)
							0: state <= F;
							1: state <= A;
						endcase
					end
					
				E: begin
						case(w)
							0: state <= E;
							1: state <= D;
						endcase
					end
					
				F: begin
						case(w)
							0: state <= C;
							1: state <= D;
						endcase
					end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			A: z <= 0;
			B: z <= 0;
			C: z <= 0;
			D: z <= 0;
			E: z <= 1;
			F: z <= 1;
		endcase
	end

endmodule
