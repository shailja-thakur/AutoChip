module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	parameter A=2'b00; // A = 00
	parameter B=2'b01; // B = 01
	parameter C=2'b10; // C = 10
	parameter D=2'b11; // D = 11
	
	reg [1:0] present_state, next_state;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			present_state <= A;
		else
			present_state <= next_state;
	end

	always @*
	begin
		case (present_state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 1'b0;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out = 1'b0;
			end
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out = 1'b0;
			end
			D: begin
				if (in)
					next_state = D;
				else
					next_state = B;
				out = 1'b1;
			end
			default: next_state = A;
		endcase
	end
endmodule
