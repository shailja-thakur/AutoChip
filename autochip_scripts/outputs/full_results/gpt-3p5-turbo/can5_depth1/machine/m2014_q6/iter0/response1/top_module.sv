module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);
	
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;
	
	reg [2:0] state;
	reg [2:0] next_state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @* begin
		case (state)
			A: begin
				if (w) begin
					next_state = A;
				end else begin
					next_state = if (w) D else B;
				end
			end
			B: begin
				next_state = if (w) C else D;
			end
			C: begin
				next_state = if (w) E else D;
			end
			D: begin
				next_state = if (w) A else F;
			end
			E: begin
				next_state = if (w) D else E;
			end
			F: begin
				next_state = if (w) C else D;
			end
			default: next_state = A;
		endcase
	end
	
	always @(state) begin
		if (state == E || state == F) begin
			z = 1;
		end else begin
			z = 0;
		end
	end
	
endmodule
