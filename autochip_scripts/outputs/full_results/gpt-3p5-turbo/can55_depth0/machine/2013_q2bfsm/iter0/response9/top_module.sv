module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	reg [3:0] current_state, next_state;
	parameter A = 4'b0000;
	parameter B = 4'b0001;
	parameter S0 = 4'b0010;
	parameter S1 = 4'b0011;
	parameter S10 = 4'b0100;
	parameter G1 = 4'b0101;
	parameter G2 = 4'b0110;
	parameter P0 = 4'b0111;
	parameter P1 = 4'b1000;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	always @(current_state or x) begin
		case (current_state)
			A: begin
				if (x) begin
					next_state = B;
				end else begin
					next_state = A;
				end
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
			G1, G2: begin
				if (y) begin
					next_state = P1;
				end else begin
					next_state = G2;
				end
			end
			P0, P1: begin
				next_state = current_state;
			end
			default: begin
				next_state = A;
			end
		endcase
	end

	assign f = (current_state == B) ? 1'b1 : 1'b0;
	assign g = (current_state == G1 || current_state == G2 || current_state == P1) ? 1'b1 : 1'b0;

endmodule
