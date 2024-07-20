module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	
	// Define state codes
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	
	reg [2:0] state;
	reg [2:0] next_state;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state, r) begin
		case (state)
			A: begin
				if (r[1] & !r[2] & !r[3])
					next_state = A;
				else if (r[1] && !(r[2] | r[3])) 
					next_state = B;
				else if (!(r[1] | r[2]) & r[3])
					next_state = C;
				else if (!(r[1] | r[2] | r[3]))
					next_state = D;
			end
			
			B: begin
				if (r[1] && (g[1] == 1))
					next_state = B;
				else if (!r[1] && (g[1] == 1))
					next_state = A;
			end
			
			C: begin
				if (r[2] && (g[2] == 1))
					next_state = C;
				else if (!r[2] && (g[2] == 1))
					next_state = A;
			end
			
			D: begin
				if (r[1] & !r[2] & !r[3])
					next_state = A;
				else if (r[1] && (g[1] == 1))
					next_state = B;
				else if (!(r[1] | r[2]) && (g[2] == 1))
					next_state = C;
				else if (!(r[1] | r[2] | r[3]))
					next_state = D;
			end
			
			default: next_state = A;
		endcase
	end
	
	assign g[1] = (state == A || state == B);
	assign g[2] = (state == A || state == C);
	assign g[3] = (state == A);
	
endmodule
