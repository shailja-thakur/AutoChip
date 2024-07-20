module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	parameter A = 0, B = 1, C = 2, D = 3; // Define states

	reg [1:0] state, next_state; // Register for current and next state

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(state or x or y) begin
		case (state)
			A: begin
				f <= 0;
				g <= 0;
				if (!resetn && x)
					next_state <= B;
				else
					next_state <= A;
			end
			B: begin
				f <= 1;
				g <= 0;
				next_state <= C;
			end
			C: begin
				f <= 0;
				g <= 0;
				if (x)
					next_state <= D;
				else
					next_state <= A;
			end
			D: begin
				f <= 0;
				g <= 1;
				if (!resetn && y)
					next_state <= D;
				else
					next_state <= A;
			end
		endcase
	end
endmodule
