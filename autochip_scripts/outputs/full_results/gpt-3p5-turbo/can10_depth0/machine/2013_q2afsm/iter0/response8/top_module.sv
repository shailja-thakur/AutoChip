module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	// Define the states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Define the register to store the current state
	reg [1:0] state;
	
	// Define the register to store the next state
	reg [1:0] next_state;
	
	// Update the state register on the rising edge of clk
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	// Logic for determining the next state
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
		endcase
	end
	
	// Assign g based on the current state
	assign g[1] = (state == B) ? 1'b1 : 1'b0;
	assign g[2] = (state == C) ? 1'b1 : 1'b0;
	assign g[3] = (state == D) ? 1'b1 : 1'b0;
endmodule
