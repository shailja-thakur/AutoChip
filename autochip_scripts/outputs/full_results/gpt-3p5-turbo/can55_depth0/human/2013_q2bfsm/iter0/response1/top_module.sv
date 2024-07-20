module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	// State Definitions
	reg [1:0] state, next_state;
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	
	// Output Declarations
	reg f;
	reg g;
	
	// Sequential Logic
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	// Combinational Logic
	always @(*) begin
		case (state)
			A: begin
				f <= 0;
				g <= 0;
				if (~resetn)
					next_state <= A;
				else
					next_state <= B;
			end
			
			B: begin
				if (x == 1'b1 && (x == #1 1'b0) && (x == #2 1'b1))
					next_state <= C;
				else
					next_state <= B;
			end
			
			C: begin
				if (y == 1'b1)
					g <= 1;
				else if (y == #1 1'b1 || y == #2 1'b1)
					g <= 1;
				else
					g <= 0;
				next_state <= C;
			end
		endcase
	end
endmodule
