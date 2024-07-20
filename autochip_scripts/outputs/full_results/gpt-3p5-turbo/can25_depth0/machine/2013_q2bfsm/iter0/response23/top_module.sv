module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

// Define states
parameter A = 0;
parameter B = 1;
parameter S0 = 2;
parameter S1 = 3;
parameter S10 = 4;
parameter G1 = 5;
parameter G2 = 6;
parameter P0 = 7;
parameter P1 = 8;

// Define current state and next state variables
reg [3:0] state_reg, state_next;

// Assign initial state
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state_reg <= A;
	end else begin
		state_reg <= state_next;
	end
end

// Assign next state based on current state and inputs
always @* begin
	case (state_reg)
		A: begin
			if (x)
				state_next = B;
			else
				state_next = A;
		end
		B: begin
			state_next = S0;
		end
		S0: begin
			if (x)
				state_next = S1;
			else
				state_next = S0;
		end
		S1: begin
			if (x)
				state_next = S1;
			else
				state_next = S10;
		end
		S10: begin
			if (x)
				state_next = G1;
			else
				state_next = S0;
		end
		G1: begin
			if (y)
				state_next = P1;
			else
				state_next = G2;
		end
		G2: begin
			if (y)
				state_next = P1;
			else
				state_next = P0;
		end
		P0: begin
			state_next = P0;
		end
		P1: begin
			state_next = P1;
		end
		default: begin
			state_next = A;
		end
	endcase
end

// Assign output signals based on current state
always @* begin
	case (state_reg)
		B: begin
			f = 1;
		end
		G1, G2, P1: begin
			g = 1;
		end
		default: begin
			g = 0;
			f = 0;
		end
	endcase
end

endmodule
