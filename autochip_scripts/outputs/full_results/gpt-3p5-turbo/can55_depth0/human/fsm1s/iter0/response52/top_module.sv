module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

reg state;

always @(posedge clk or posedge reset) begin
	if(reset)
		state <= B;
	else begin
		case(state)
			B: begin
				if(in)
					state <= B;
				else
					state <= A;
			end
			A: begin
				if(in)
					state <= A;
				else
					state <= B;
			end
		endcase
	end
end

always @(state) begin
	case(state)
		B: out = 1;
		A: out = 0;
	endcase
end

endmodule
