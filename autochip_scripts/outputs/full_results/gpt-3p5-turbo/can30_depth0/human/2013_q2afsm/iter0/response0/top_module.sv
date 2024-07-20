module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

reg [3:1] state, next_state;
assign g = state;

parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= A;
	else
		state <= next_state;
end

always @(state, r) begin
	case (state)
		A: begin
			if (r[1])
				next_state = B;
			else if (r[2])
				next_state = C;
			else if (r[3])
				next_state = D;
			else
				next_state = A;
		end
		
		B: begin
			if (r[1])
				next_state = B;
			else
				next_state = A;
		end
		
		C: begin
			if (r[2])
				next_state = C;
			else
				next_state = A;
		end
		
		D: begin
			next_state = A;
		end
	endcase
end
endmodule
