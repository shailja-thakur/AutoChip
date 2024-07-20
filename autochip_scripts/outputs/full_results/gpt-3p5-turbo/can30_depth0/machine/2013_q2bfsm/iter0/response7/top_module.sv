module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State enumeration
	typedef enum logic [3:0] {
		A,
		B,
		S0,
		S1,
		S10,
		G1,
		G2,
		P0,
		P1
	} state_t;
	
	// Declare the state and next_state signals
	reg state_t state;
	reg state_t next_state;
	
	// Assign f to 1 when the state is B
	always @(state)
	begin
		if (state == B)
			f = 1'b1;
		else
			f = 1'b0;
	end
	
	// Assign g to 1 when the state is G1 or G2 or P1
	always @(state)
	begin
		if (state == G1 || state == G2 || state == P1)
			g = 1'b1;
		else
			g = 1'b0;
	end
	
	// Sequential state update
	always @(posedge clk or negedge resetn)
	begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	// Combinational next state logic
	always @(*)
	begin
		case (state)
			A:
				next_state = B;
			B:
				next_state = S0;
			S0:
				if (x)
					next_state = S1;
				else
					next_state = S0;
			S1:
				if (x)
					next_state = S1;
				else
					next_state = S10;
			S10:
				if (x)
					next_state = G1;
				else
					next_state = S0;
			G1:
				if (y)
					next_state = P1;
				else
					next_state = G2;
			G2:
				if (y)
					next_state = P1;
				else
					next_state = P0;
			P0:
				next_state = P0;
			P1:
				next_state = P1;
			default:
				next_state = A;
		endcase
	end
	
endmodule
