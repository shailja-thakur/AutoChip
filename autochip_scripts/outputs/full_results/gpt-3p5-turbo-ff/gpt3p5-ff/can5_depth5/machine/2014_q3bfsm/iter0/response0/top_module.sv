module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(state or x) begin
	case(state)
		A: begin
			if (x)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (x)
				next_state = E;
			else
				next_state = B;
		end
		C: begin
			if (x)
				next_state = B;
			else
				next_state = C;
		end
		D: begin
			if (x)
				next_state = C;
			else
				next_state = B;
		end
		E: begin
			if (x)
				next_state = E;
			else
				next_state = D;
		end
		default: next_state = A;
	end

	if (state == D || state == E)
		z = 1;
	else
		z = 0;
end

endmodule
