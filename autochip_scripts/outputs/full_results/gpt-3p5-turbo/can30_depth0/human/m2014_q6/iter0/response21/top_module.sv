module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	reg [2:0] state, next_state;

	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or w) begin
		case (state)
			A: if (w) begin
				   next_state = A;
			   end else begin
				   next_state = B;
			   end
			
			B: if (w) begin
				   next_state = D;
			   end else begin
				   next_state = C;
			   end
			
			C: if (w) begin
				   next_state = D;
			   end else begin
				   next_state = E;
			   end
			
			D: if (w) begin
				   next_state = A;
			   end else begin
				   next_state = F;
			   end
			
			E: if (w) begin
				   next_state = D;
			   end else begin
				   next_state = E;
			   end
			
			F: if (w) begin
				   next_state = D;
			   end else begin
				   next_state = C;
			   end
			
			default: next_state = A;
		endcase
	end
	
	always @(posedge clk) begin
		if (reset) begin
			z <= 0;
		end else begin
			case (state)
				E: z <= 1;
				default: z <= 0;
			endcase
		end
	end
	
endmodule
