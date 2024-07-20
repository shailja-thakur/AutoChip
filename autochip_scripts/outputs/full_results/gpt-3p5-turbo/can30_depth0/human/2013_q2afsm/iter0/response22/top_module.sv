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
	
	// Declare the state and next_state variables
	reg [1:0] state, next_state;

	// Declare the g signals
	wire g1, g2, g3;
	
	// Assign the g signals based on the state
	assign g = {g3, g2, g1};

	// Synchronous reset
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	// State transition logic
	always @(state, r) begin
		next_state = state;
		case (state)
			A: begin
				if (r[1])
					next_state = B;
				else if (r[2])
					next_state = C;
				else if (r[3])
					next_state = D;
			end
			B: begin
				if (r[1] && g1)
					next_state = B;
				else
					next_state = A;
			end
			C: begin
				if (r[2] && g2)
					next_state = C;
				else
					next_state = A;
			end
			D: begin
				next_state = A;
			end
		endcase
	end

	// Output logic
	always @(state) begin
		case (state)
			A: begin
				g1 = 1'b0;
				g2 = 1'b0;
				g3 = 1'b0;
			end
			B: begin
				g1 = 1'b1;
				g2 = 1'b0;
				g3 = 1'b0;
			end
			C: begin
				g1 = 1'b0;
				g2 = 1'b1;
				g3 = 1'b0;
			end
			D: begin
				g1 = 1'b0;
				g2 = 1'b0;
				g3 = 1'b0;
			end
		endcase
	end

endmodule
