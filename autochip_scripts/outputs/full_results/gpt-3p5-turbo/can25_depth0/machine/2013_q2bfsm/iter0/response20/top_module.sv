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

// Assign initial state
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A;
	end else begin
		state <= next_state;
	end
end

// Assign next state based on current state and input signals
always @(state, x, y) begin
	next_state = state;
	case (state)
		A: begin
			if (x) begin
				next_state = B;
			end
		end
		B: begin
			next_state = S0;
		end
		S0: begin
			if (x) begin
				next_state = S1;
			end
		end
		S1: begin
			if (x) begin
				next_state = S1;
			end else begin
				next_state = S10;
			end
		end
		S10: begin
			if (x) begin
				next_state = G1;
			end else begin
				next_state = S0;
			end
		end
		G1: begin
			if (y) begin
				next_state = P1;
			end else begin
				next_state = G2;
			end
		end
		G2: begin
			if (y) begin
				next_state = P1;
			end else begin
				next_state = P0;
			end
		end
		P0: begin
			// Stay in P0
		end
		P1: begin
			// Stay in P1
		end
	endcase
end

// Assign output signals based on current state
always @(state) begin
	case (state)
		B: begin
			f = 1;
		end
		G1, G2, P1: begin
			g = 1;
		end
		default: begin
			f = 0;
			g = 0;
		end
	endcase
end

endmodule
