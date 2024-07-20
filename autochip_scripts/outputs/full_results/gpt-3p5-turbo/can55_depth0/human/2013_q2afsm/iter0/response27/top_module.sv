module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
// FSM states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= A;
	else
		state <= next_state;
end

always @(*) begin
	next_state = state;
	
	case (state)
		A: begin
			// Grant signals
			g[1] = (r[1] && !r[2] && !r[3]) ? 1'b1 : 1'b0;
			g[2] = 1'b0;
			g[3] = 1'b0;
			
			// State transitions
			if (r[1])
				next_state = B;
			else if (r[2])
				next_state = C;
			else if (r[3])
				next_state = D;
		end
		
		B: begin
			// Grant signals
			g[1] = (r[1] && g[1]) ? 1'b1 : 1'b0;
			g[2] = (r[2] && !r[1] && !r[3]) ? 1'b1 : 1'b0;
			g[3] = 1'b0;
			
			// State transitions
			if (r[1] && !g[1])
				next_state = A;
		end
		
		C: begin
			// Grant signals
			g[1] = (r[1] && !r[2] && !r[3]) ? 1'b1 : 1'b0;
			g[2] = (r[2] && g[2]) ? 1'b1 : 1'b0;
			g[3] = 1'b0;
			
			// State transitions
			if (r[2] && !g[2])
				next_state = A;
		end
		
		D: begin
			// Grant signals
			g[1] = (r[1] && !r[2] && !r[3]) ? 1'b1 : 1'b0;
			g[2] = 1'b0;
			g[3] = (r[3] && !r[1] && !r[2]) ? 1'b1 : 1'b0;
			
			// State transitions
			if (r[1])
				next_state = B;
			else if (r[2])
				next_state = C;
			else if (!r[3])
				next_state = A;
		end
	endcase
end

endmodule
