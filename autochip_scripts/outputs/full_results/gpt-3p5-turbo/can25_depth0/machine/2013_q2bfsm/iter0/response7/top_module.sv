module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter S0 = 2'b10;
parameter S1 = 2'b11;
parameter S10 = 3'b100;
parameter G1 = 3'b101;
parameter G2 = 3'b110;
parameter P0 = 3'b111;
parameter P1 = 3'b000;

reg [2:0] state, next_state;

// Initialize state
always @(posedge clk or negedge resetn) begin
	if (!resetn)
		state <= A;
	else
		state <= next_state;
end

// Assign next_state based on current state and inputs
always @(*) begin
	case (state)
		A: begin
			if (x)
				next_state = B;
			else
				next_state = S0;
		end

		B: next_state = S0;

		S0: begin
			if (x)
				next_state = S1;
			else
				next_state = S0;
		end

		S1: begin
			if (x)
				next_state = S1;
			else
				next_state = S10;
		end

		S10: begin
			if (x)
				next_state = G1;
			else
				next_state = S0;
		end

		G1: begin
			if (y)
				next_state = P1;
			else
				next_state = G2;
		end

		G2: begin
			if (y)
				next_state = P1;
			else
				next_state = P0;
		end

		P0: next_state = P0;

		P1: next_state = P1;
	endcase
end

// Assign outputs based on current state
always @* begin
	f = (state == B) ? 1'b1 : 1'b0;
	g = (state == G1 || state == G2 || state == P1) ? 1'b1 : 1'b0;
end

endmodule
