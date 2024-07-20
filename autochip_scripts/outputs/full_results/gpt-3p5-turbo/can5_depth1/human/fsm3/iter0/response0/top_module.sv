module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);
 
reg [1:0] state, next_state;
 
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;
 
always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else
		state <= next_state;
end
 
always @(*) begin
	case (state)
		A:
			if (in == 1)
				next_state = B;
			else
				next_state = A;
		B:
			if (in == 1)
				next_state = B;
			else
				next_state = C;
		C:
			if (in == 1)
				next_state = D;
			else
				next_state = A;
		D:
			if (in == 1)
				next_state = B;
			else
				next_state = C;
	endcase
end
 
always @(state) begin
	case (state)
		A: out = 0;
		B: out = 0;
		C: out = 0;
		D: out = 1;
	endcase
end

endmodule
