module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg [1:0] next_state;
reg [1:0] current_state;

parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @* begin
	current_state = state;
	case (current_state)
		A: begin
			if (w == 0)
				next_state = B;
			else if (w == 1)
				next_state = A;
		end
		B: begin
			if (w == 0)
				next_state = C;
			else if (w == 1)
				next_state = D;
		end
		C: begin
			if (w == 0)
				next_state = E;
			else if (w == 1)
				next_state = D;
		end
		D: begin
			if (w == 0)
				next_state = F;
			else if (w == 1)
				next_state = A;
		end
		E: begin
			if (w == 0)
				next_state = E;
			else if (w == 1)
				next_state = D;
		end
		F: begin
			if (w == 0)
				next_state = C;
			else if (w == 1)
				next_state = D;
		end
	endcase
end

always @(posedge clk) begin
	case (state)
		A: z <= 0;
		B: z <= 0;
		C: z <= 0;
		D: z <= 0;
		E: z <= 1;
		F: z <= 1;
	endcase
end

endmodule
