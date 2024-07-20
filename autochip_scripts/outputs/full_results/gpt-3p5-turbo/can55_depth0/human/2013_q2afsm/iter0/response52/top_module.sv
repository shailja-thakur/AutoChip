module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

	// State codes
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;

	// Flip-flops to store the current state
	reg [2:0] current_state;
	reg [2:0] next_state;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// State table
	always @(current_state, r) begin
		case (current_state)
			A: begin
				if (r[0])
					next_state <= B;
				else if (r[1])
					next_state <= C;
				else if (r[2])
					next_state <= D;
				else
					next_state <= A;
			end

			B: begin
				if (r[0] && g[0])
					next_state <= B;
				else
					next_state <= A;
			end

			C: begin
				if (r[1] && g[1])
					next_state <= C;
				else
					next_state <= A;
			end

			D: begin
				if (r[0] || r[1] || r[2])
					next_state <= D;
				else
					next_state <= A;
			end
		endcase
	end

	// FSM outputs
	always @(current_state) begin
		case (current_state)
			A: g <= 3'b000;
			B: g <= 3'b100;
			C: g <= 3'b010;
			D: g <= 3'b001;
		endcase
	end

endmodule
