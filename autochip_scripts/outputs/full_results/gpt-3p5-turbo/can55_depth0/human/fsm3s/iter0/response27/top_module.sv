module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state, next_state;
reg output;

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(*) begin
	case(state)
		A: begin
			if(in)
				next_state = B;
			else
				next_state = A;
			
			output = 0;
		end
		
		B: begin
			if(in)
				next_state = B;
			else
				next_state = C;
			
			output = 0;
		end
		
		C: begin
			if(in)
				next_state = D;
			else
				next_state = A;
			
			output = 0;
		end
		
		D: begin
			if(in)
				next_state = B;
			else
				next_state = C;
			
			output = 1;
		end
	endcase
end

assign out = output;

endmodule
