module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// define state enumeration
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
	} state_type;
	
	reg state;
	reg nextState;
	
	// output signals
	assign f = (state == B);
	assign g = (state == G1 || state == G2 || state == P1);
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			state <= nextState;
		end
	end
	
	always @(*) begin
		nextState = state;
		case (state)
			A: begin
				if (x) begin
					nextState = B;
				end else begin
					nextState = S0;
				end
			end
			B: begin
				nextState = S0;
			end
			S0: begin
				if (x) begin
					nextState = S1;
				end
			end
			S1: begin
				if (x) begin
					nextState = S1;
				end else begin
					nextState = S10;
				end
			end
			S10: begin
				if (x) begin
					nextState = G1;
				end else begin
					nextState = S0;
				end
			end
			G1: begin
				if (y) begin
					nextState = P1;
				end else begin
					nextState = G2;
				end
			end
			G2: begin
				if (y) begin
					nextState = P1;
				end else begin
					nextState = P0;
				end
			end
			P0, P1: begin
				nextState = state;
			end
		endcase
	end
	
endmodule
