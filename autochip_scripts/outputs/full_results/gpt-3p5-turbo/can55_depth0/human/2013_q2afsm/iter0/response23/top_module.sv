module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

// Define state codes
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state;
reg [3:1] g_internal;

// Sequential block for state flip-flops
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		case (state)
			// Transition conditions and next states for state A
			A: begin
				if (~r[1] && ~r[2] && ~r[3])
					state <= A;
				else if (r[1])
					state <= B;
				else if (~r[1] && r[2])
					state <= C;
				else if (~r[1] && ~r[2] && ~r[3])
					state <= D;
			end
			// Transition conditions and next states for state B
			B: begin
				if (g_internal[1])
					state <= B;
				else if (~r[1])
					state <= A;
			end
			// Transition conditions and next states for state C
			C: begin
				if (g_internal[2])
					state <= C;
				else if (~r[2])
					state <= A;
			end
			// Transition conditions and next states for state D
			D: begin
				if (~r[1] && ~r[2] && ~r[3])
					state <= A;
			end
		endcase
	end
end

// Continuous assignment for g[i]
always @(*) begin
	case (state)
		A: g_internal = 3'b000;
		B: g_internal = 3'b100;
		C: g_internal = 3'b010;
		D: g_internal = 3'b000;
	endcase
	g = g_internal;
end

endmodule
