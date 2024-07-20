module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// States
	typedef enum logic [3:0] {
		S0,
		S1,
		S10,
		G1,
		G2,
		P0,
		P1
	} state_t;

	// State register
	reg state_t current_state, next_state;

	// Initialization
	initial begin
		current_state <= S0;
		f <= 0;
		g <= 0;
	end

	// Combinational logic
	always_comb begin
		case (current_state)
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
			P0, P1: begin
				next_state = current_state;
			end
			default: next_state = S0;
		endcase
	end

	// Sequential logic
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn)
			current_state <= S0;
		else
			current_state <= next_state;
	end

	// Output logic
	always_comb begin
		f = (current_state == G1 || current_state == G2 || current_state == P1) ? 1'b1 : 1'b0;
		g = (current_state == G1 || current_state == G2 || current_state == P1) ? 1'b1 : 1'b0;
	end

endmodule
