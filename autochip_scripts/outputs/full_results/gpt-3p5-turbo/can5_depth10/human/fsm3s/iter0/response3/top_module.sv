module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] current_state, next_state;

	always@(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else 
			current_state <= next_state;
	end

	always@(*) begin
		case (current_state)
			A: begin
				if(in)
					next_state = B;
				else
					next_state = A;
				out = 1'b0;
			end
			
			B: begin
				if(in)
					next_state = B;
				else
					next_state = C;
				out = 1'b0;
			end
			
			C: begin
				if(in)
					next_state = D;
				else
					next_state = A;
				out = 1'b0;
			end
			
			D: begin
				if(in)
					next_state = B;
				else
					next_state = C;
				out = 1'b1;
			end
		endcase
	end
endmodule
