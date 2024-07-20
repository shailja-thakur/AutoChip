module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
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

// Assign next state logic
always @(*) begin
	case (state)
		A: begin
			next_state = B;
		end
		B: begin
			next_state = S0;
		end
		S0: begin
			if (x) begin
				next_state = S1;
			end else begin
				next_state = S0;
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
			next_state = P0;
		end
		P1: begin
			next_state = P1;
		end
	endcase
end

// Assign outputs
assign f = (state == B);
assign g = (state == G1 || state == G2 || state == P1);

endmodule
