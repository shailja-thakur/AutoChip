module top_module (
	input clk,
	input in,
	input areset,
	output out
);
// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= A;
		else
			case(state)
				A: begin
					if (in)
						state <= B;
					else
						state <= A;
				end
				B: begin
					if (in)
						state <= B;
					else
						state <= C;
				end
				C: begin
					if (in)
						state <= D;
					else
						state <= A;
				end
				D: begin
					if (in)
						state <= B;
					else
						state <= C;
				end
			endcase
	end
	
always @(state)
	begin
		case(state)
			A: out = 1'b0;
			B: out = 1'b0;
			C: out = 1'b0;
			D: out = 1'b1;
		endcase
	end
    
endmodule
