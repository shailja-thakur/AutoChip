module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	parameter A = 0;
	parameter B = 1;
	reg current_state, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always @(*) begin
		next_state = current_state;
		case (current_state)
			A: begin
				if (s == 1)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				if ((w == 1) && (w == #(1) w == #(1)))
					next_state = A;
				else
					next_state = B;
			end
		endcase
	end
	
	always @(posedge clk) begin
		case (current_state)
			A: z <= 0;
			B: z <= 1;
		endcase
	end
endmodule
