module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// State encoding
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;
	
	reg [1:0] state, next_state;
	
	// State flip-flops (sequential logic)
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A; // Reset to the initial state A
		else
			state <= next_state; // Transition to the next state
	end
	
	// State table (combinational logic)
	always @(*) begin
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
				if (r[3])
					next_state = D;
				else
					next_state = A;
			end
			default: next_state = A;
		endcase
	end
	
	// Output logic (can be continuous assignment or inside an always block)
	assign g[1] = (state == B) ? 1'b1 : 1'b0;
	assign g[2] = (state == C) ? 1'b1 : 1'b0;
	assign g[3] = (state == D) ? 1'b1 : 1'b0;

endmodule
