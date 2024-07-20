module top_module (
	input clk,
	input in,
	input areset,
	output out
	
);
	parameter B = 0;
	parameter A = 1;
	
	reg [1:0] current_state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= B;
		else
			current_state <= next_state;
	end
	
	always @(current_state, in) begin
		case (current_state)
			B: begin
				case (in)
					0: next_state <= A;
					1: next_state <= B;
				endcase
			end
			A: begin
				case (in)
					0: next_state <= B;
					1: next_state <= A;
				endcase
			end
		endcase
	end
	
	always @(current_state) begin
		case (current_state)
			B: out <= 1;
			A: out <= 0;
		endcase
	end
endmodule
