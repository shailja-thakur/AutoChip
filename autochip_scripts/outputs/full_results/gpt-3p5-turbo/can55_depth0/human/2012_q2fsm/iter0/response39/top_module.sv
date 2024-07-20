module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state, next_state;
	
	// State table
	always @(state, w) begin
		case (state)
			A: begin
				if (w)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
			
			C: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end
			
			D: begin
				if (w)
					next_state = F;
				else
					next_state = A;
			end
			
			E: begin
				if (w)
					next_state = E;
				else
					next_state = D;
			end
			
			F: begin
				if (w)
					next_state = C;
				else
					next_state = D;
			end
		endcase
	end
	
	// State flip-flops
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end
	
	// Output logic
	always @(state) begin
		case (state)
			A: z = 1'b0;
			B: z = 1'b0;
			C: z = 1'b0;
			D: z = 1'b0;
			E: z = 1'b1;
			F: z = 1'b1;
		endcase
	end
	
endmodule
