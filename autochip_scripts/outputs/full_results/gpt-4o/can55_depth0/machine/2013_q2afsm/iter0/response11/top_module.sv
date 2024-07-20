module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output reg [3:1] g
);

	// State encoding
	localparam A = 2'd0;
	localparam B = 2'd1;
	localparam C = 2'd2;
	localparam D = 2'd3;

	reg [1:0] state, next_state;

	// State transition logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (r[1]) next_state = B;
				else if (r[2]) next_state = C;
				else if (r[3]) next_state = D;
				else next_state = A;
			end
			B: begin
				if (r[1]) next_state = B;
				else next_state = A;
			end
			C: begin
				if (r[2]) next_state = C;
				else next_state = A;
			end
			D: begin
				if (r[3]) next_state = D;
				else next_state = A;
			end
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(*) begin
		g = 3'b000;
		case (state)
			B: g[1] = 1'b1;
			C: g[2] = 1'b1;
			D: g[3] = 1'b1;
			default: g = 3'b000;
		endcase
	end

endmodule
