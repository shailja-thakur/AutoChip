module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
reg [3:1] g;

parameter A = 3'b001;
parameter B = 3'b010;
parameter C = 3'b011;
parameter D = 3'b100;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		state <= A;
	else
		state <= next_state;
end

always @* begin
	case (state)
		A: begin
			if (r[1] && r[2] && r[3])
				next_state = A;
			else if (r[1])
				next_state = B;
			else if (r[2])
				next_state = C;
			else if (r[3])
				next_state = D;
		end
		B: begin
			if (g[1])
				next_state = B;
			else
				next_state = A;
		end
		C: begin
			if (g[2])
				next_state = C;
			else
				next_state = A;
		end
		D: begin
			if (r[1] && r[2] && r[3])
				next_state = A;
			else
				next_state = D;
		end
	endcase
end

always @* begin
	g[1] = (state == B) || (state == D);
	g[2] = (state == C);
	g[3] = (state == D);
end

endmodule
