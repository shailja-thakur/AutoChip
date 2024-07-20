module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg out;

parameter B = 1'b1;
parameter A = 1'b0;

reg state, next_state;

always@(posedge clk or posedge reset)
begin
	if (reset)
		state <= B;
	else
		state <= next_state;
end

always@(state or in)
begin
	case(state)
		B: begin
			if (in)
				next_state = B;
			else
				next_state = A;
                  
			out = 1'b1;
		end
		
		A: begin
			if (in)
				next_state = A;
			else
				next_state = B;
                  
			out = 1'b0;
		end
	endcase
end

endmodule
