module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	always @* begin
		case (state)
			A: begin
				if (w == 1'b0)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				if (w == 1'b0)
					next_state = C;
				else
					next_state = D;
			end
			
			C: begin
				if (w == 1'b0)
					next_state = E;
				else
					next_state = D;
			end
			
			D: begin
				if (w == 1'b0)
					next_state = F;
				else
					next_state = A;
			end
			
			E: begin
				if (w == 1'b0)
					next_state = E;
				else
					next_state = D;
			end
			
			F: begin
				if (w == 1'b0)
					next_state = C;
				else
					next_state = D;
			end
		endcase
	end
	
	always @(posedge clk) begin
		if (reset)
			z <= 1'b0;
		else begin
			case (state)
				E: z <= 1'b1;
				default: z <= 1'b0;
			endcase
		end
	end
	
endmodule
