module top_module (
	input clk,
	input reset,
	input w,
	output z
);

parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

reg [2:0] current_state;
reg [2:0] next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		current_state <= A;
	else
		current_state <= next_state;
end

always @* begin
	case (current_state)
		A: begin
			if (w == 0)
				next_state = B;
			else
				next_state = A;
		end
		B: begin
			if (w == 0)
				next_state = C;
			else
				next_state = D;
		end
		C: begin
			if (w == 0)
				next_state = E;
			else
				next_state = D;
		end
		D: begin
			if (w == 0)
				next_state = F;
			else
				next_state = A;
		end
		E: begin
			if (w == 0)
				next_state = E;
			else
				next_state = D;
		end
		F: begin
			if (w == 0)
				next_state = C;
			else
				next_state = D;
		end
	endcase
end

assign z = (current_state == E || current_state == F) ? 1 : 0;

endmodule
