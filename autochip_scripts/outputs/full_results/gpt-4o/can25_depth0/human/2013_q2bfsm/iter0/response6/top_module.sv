module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	typedef enum reg [1:0] { A, B, C, D, E, F, G } state_t;
	state_t state, next_state;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			f <= 0;
			g <= 0;
		end 
		else begin
			case (state)
				B: f <= 1;
				D: g <= 1;
				E: g <= 1;
				F: g <= 1;
				G: g <= 0;
				default: begin
					f <= 0;
					g <= 0;
				end
			endcase
		end
	end

	always @(*) begin
		next_state = state;
		case (state)
			A: if (resetn) next_state = B;
			B: next_state = C;
			C: if (x == 1) next_state = D;
			D: if (x == 0) next_state = E;
			E: if (x == 1) next_state = F;
			F: if (y == 1) next_state = F; 
			   else       next_state = G;
			G: if (resetn) next_state = A;
			default: next_state = A;
		endcase
	end

endmodule
