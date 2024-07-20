module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);

	// Define FSM states as parameters
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;

	// Define state and next_state variables
	reg [2:0] state;
	reg [2:0] next_state;

	// Define g1, g2, g3 outputs
	reg [2:0] g1;
	reg [2:0] g2;
	reg [2:0] g3;

	// State transition and output logic
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(*) begin
		g1 = {1'b0, (state == B)};
		g2 = {1'b0, (state == C)};
		g3 = {1'b0, (state == D)};
	end

	// Next state and output generation logic
	always @(*) begin
		case (state)
			A: begin
				if (r[1] && ~r[2] && ~r[3])
					next_state = B;
				else if (r[2] && ~r[1] && ~r[3])
					next_state = C;
				else if (~r[1] && ~r[2] && ~r[3])
					next_state = D;
				else
					next_state = A;
			end
			B: begin
				if (r[1])
					next_state = B;
				else if (g1[1])
					next_state = B;
				else
					next_state = A;
			end
			C: begin
				if (r[2])
					next_state = C;
				else if (g2[2])
					next_state = C;
				else
					next_state = A;
			end
			D: begin
				next_state = A;
			end
		endcase
	end

	// Assign outputs
	assign g[1] = g1[1];
	assign g[2] = g2[2];
	assign g[3] = g3[3];
endmodule
